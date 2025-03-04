lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'bobross/version'

Gem::Specification.new do |spec|
  spec.name          = 'bobross'
  spec.version       = Bobross::VERSION
  spec.authors       = ['Jacob Slack', 'Trevor Byington']
  spec.email         = ['tbyington@instructure.com', 'tabyington@gmail.com']

  spec.summary       = 'Generates data to put in your canvas instance.'
  spec.description   = 'Generates data to put in your canvas instance. Data can be exported as CSV for uploading or sent directly via api call'
  spec.homepage      = 'https://rubygems.org/gems/bobross'
  spec.license       = 'MIT'

  # Prevent pushing this gem to RubyGems.org. To allow pushes either set the 'allowed_push_host'
  # to allow pushing to a single host or delete this section to allow pushing to any host.
  if spec.respond_to?(:metadata)
    spec.metadata['allowed_push_host'] = 'https://rubygems.org'
    spec.metadata['homepage_uri'] = spec.homepage
    spec.metadata['source_code_uri'] = 'https://github.com/instructurecustomdevqa/bobross'
  else
    raise 'RubyGems 2.0 or newer is required to protect against public gem pushes.'
  end

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files = Dir.chdir(File.expand_path('..', __FILE__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_dependency 'bearcat', '~> 1.4.10'
  spec.add_dependency 'bundler', '~> 2.3.14'
  spec.add_dependency 'faker'
  spec.add_dependency 'rake', '~> 13.0.6'
  spec.add_development_dependency 'rspec', '~> 3.11.0'
end
