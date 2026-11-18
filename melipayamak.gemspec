require_relative 'melipayamak/version'

Gem::Specification.new do |spec|
  spec.name          = 'melipayamak'
  spec.version       = Melipayamak::VERSION
  spec.authors       = ['Melipayamak']
  spec.summary       = 'Ruby wrapper for Melipayamak SMS API'
  spec.description   = 'A Ruby client for interacting with Melipayamak web services.'
  spec.homepage      = 'https://github.com/Melipayamak/melipayamak-ruby'
  spec.license       = 'MIT'

  spec.required_ruby_version = '>= 2.7'

  spec.files = Dir.chdir(__dir__) do
    `git ls-files -z`.split("\x0").reject do |file|
      file.start_with?('test/', 'spec/', '.github/')
    end
  end

  spec.require_paths = ['.']

  spec.add_dependency 'http'
  spec.add_dependency 'savon'
end
