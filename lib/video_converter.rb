require 'fileutils'
require 'streamio-ffmpeg'
require 'concurrent'

module VideoConverter
  class Converter
    attr_accessor :max_concurrency, :batch_size, :conversion_delay

    def initialize(max_concurrency: 2, batch_size: 20, conversion_delay: 0.5)
      @max_concurrency = max_concurrency
      @batch_size = batch_size
      @conversion_delay = conversion_delay
    end

    def convert_file(source_file, target_file)
      movie = FFMPEG::Movie.new(source_file)
      movie.transcode(target_file)
    end

    def rename_and_convert_files(dir, source_ext, target_ext)
      convert_files_in_batch(get_source_files_recursive(dir, source_ext), source_ext, target_ext)
    end

    def get_source_files_recursive(dir, source_ext)
      source_files = []
      Dir.foreach(dir) do |file|
        next if file == '.' || file == '..'

        current_path = File.join(dir, file)
        if File.directory?(current_path)
          source_files.concat(get_source_files_recursive(current_path, source_ext)) # Recursively call for subdirectories
        elsif file.end_with?(source_ext)
          source_files << current_path
        end
      end

      source_files
    end

    def convert_files_in_batch(files, source_ext, target_ext)
      executor = Concurrent::ThreadPoolExecutor.new(
        min_threads: 1,
        max_threads: max_concurrency,
        max_queue: files.size,
        fallback_policy: :caller_runs
      )

      files.each do |file|
        executor.post do
          new_filename = file.gsub(source_ext, target_ext)
          if !File.exist?(new_filename)
            convert_file(file, new_filename)
            puts "Converted: #{file} -> #{new_filename}"
            FileUtils.rm(file) # Remove the original file after conversion
          else
            puts "Skipped conversion (already exists): #{file}"
          end
        end
      end

      executor.shutdown
      executor.wait_for_termination
    end

    def convert_single_file(source_file, target_file = nil, target_format = nil)
      if File.exist?(source_file)
        if target_file.nil? && !target_format.nil?
          target_file = source_file.gsub(File.extname(source_file), target_format)
        end

        convert_file(source_file, target_file)
        puts "Converted: #{source_file} -> #{target_file}"
        FileUtils.rm(source_file) # Remove the original file after conversion
      else
        puts "File not found: #{source_file}"
      end
    end
  end
end
