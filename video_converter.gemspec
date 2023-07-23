lib = File.expand_path('lib', __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'video_converter/version'

Gem::Specification.new do |spec|
  spec.name          = 'video_conv'
  spec.version       = VideoConverter::VERSION
  spec.authors       = ['Webster']
  spec.email         = ['webster@asu.edu']
  spec.summary       = 'A Ruby gem for video format conversion with customizable options'
  spec.description   = 'Convert video formats with custom concurrency, batch size, and conversion delay'
  spec.homepage      = 'https://github.com/avosa/video_converter'
  spec.license       = 'MIT'

  spec.files         = Dir['lib/**/*']
  spec.require_paths = ['lib']

  spec.add_runtime_dependency 'streamio-ffmpeg'
  spec.add_development_dependency 'rspec'
end
