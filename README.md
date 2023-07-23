# Video Converter

![Gem Version](https://img.shields.io/gem/v/video_converter)

[video-converter](https://github.com/avosa/video_converter) is a Ruby gem that allows users to convert video files with custom concurrency, batch size, and conversion delay. It uses the `streamio-ffmpeg` library for video conversion, giving you the flexibility to convert video files to various formats efficiently.

## Features

- Convert files with customizable concurrency, batch size, and conversion delay.
- Utilize the power of `streamio-ffmpeg` for efficient video conversion.
- Supports converting files with various extensions to different output formats.

## Installation

Install the gem using RubyGems:

```bash
gem install video_conv
```

Or add it to your project's Gemfile:

```bash
gem 'video_conv'
```

And then run:

```bash
bundle install
```

## Usage

Require the gem and create a new converter object with custom options.

To convert batch files to the desired format you can use the `rename_and_convert_files` method . For example:

```ruby

require 'video_converter'

# Create a new converter object with custom options
converter = VideoConverter::Converter.new(max_concurrency: 4, batch_size: 30, conversion_delay: 1)

# Set the root directory for file conversion
root_directory = '.' # Change this to the desired root directory

# Customize the source and target file formats
source_format = '.ts' # Customize the source file format
target_format = '.mp4' # Customize the target file format

# Start the conversion process
converter.rename_and_convert_files(root_directory, source_format, target_format)
```

To convert a specific file to the desired format you can use the `convert_single_file` method . For example:

```ruby

require 'video_converter'

converter = VideoConverter::Converter.new

# Convert a single file:
source_file = 'path/to/source_file.ts'
target_file = 'path/to/target_file.mp4'
converter.convert_single_file(source_file, target_file)
```

## Customization Options
The `VideoConverter::Converter` object can be customized with the following options:

- max_concurrency: The maximum number of concurrent conversions to run (default is 2).
- batch_size: The number of files processed in each round of conversions (default is 20).
- conversion_delay: The delay (in seconds) between each batch of conversions (default is 0.5).

## Contributing
Bug reports and pull requests are welcome on GitHub at https://github.com/avosa/video_converter.

## Acknowledgments
The File Converter gem relies on the [streamio-ffmpeg](https://github.com/streamio/streamio-ffmpeg) library for video conversion.

## Authors
- [Webster Avosa](https://github.com/avosa)

Enjoy!
