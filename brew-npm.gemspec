require_relative 'lib/brew/npm/version'

Gem::Specification.new do |spec|
  spec.name          = "brew-npm"
  spec.version       = Brew::Npm::VERSION
  spec.authors       = ["motoki-shun"]
  spec.email         = ["shuuuuuny+github@gmail.com"]

  spec.summary       = %q{Generate Homebrew formulas to install standalone npms.}
  spec.description   = %q{This gem can be installed with "brew install brew-npm" and used to install gems with "brew npm install <npm>".}
  spec.homepage      = "https://github.com/shuuuuun/brew-npm"
  spec.license       = "MIT"
  spec.required_ruby_version = Gem::Requirement.new(">= 2.3.0")

  spec.metadata["allowed_push_host"] = "https://rubygems.org"
  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = "https://github.com/shuuuuun/brew-npm"
  # spec.metadata["changelog_uri"] = "TODO: Put your gem's CHANGELOG.md URL here."

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files         = Dir.chdir(File.expand_path('..', __FILE__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]
end
