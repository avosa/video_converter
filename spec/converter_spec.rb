require 'video_converter' # Load the main gem file

RSpec.describe VideoConverter::Converter do
  subject(:converter) { described_class.new }

  # Stub the transcode method to avoid actual file conversion
  before do
    allow_any_instance_of(FFMPEG::Movie).to receive(:transcode)
  end

  describe '#convert_file' do
    it 'calls transcode method with correct arguments' do
      source_file = 'test_videos/source_file.ts'
      target_file = 'test_videos/target_file.mp4'

      expect_any_instance_of(FFMPEG::Movie).to receive(:transcode).with(target_file)
      converter.convert_file(source_file, target_file)
    end
  end

  describe '#convert_single_file' do
    context 'when the source file exists' do
      it 'calls transcode method with correct arguments and removes the source file' do
        source_file = 'test_videos/source_file.ts'
        target_file = 'test_videos/target_file.mp4'

        expect_any_instance_of(FFMPEG::Movie).to receive(:transcode).with(target_file)
        expect(FileUtils).to receive(:rm).with(source_file)

        converter.convert_single_file(source_file, target_file)
      end
    end

    context 'when the source file does not exist' do
      it 'displays an error message' do
        source_file = 'test_videos/non_existent_file.ts'
        target_file = 'test_videos/target_file.mp4'

        expect_any_instance_of(FFMPEG::Movie).not_to receive(:transcode)
        expect(FileUtils).not_to receive(:rm)

        expect { converter.convert_single_file(source_file, target_file) }
          .to output("File not found: #{source_file}\n").to_stdout
      end
    end
  end
end
