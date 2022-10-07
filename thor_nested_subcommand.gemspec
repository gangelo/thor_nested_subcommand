# frozen_string_literal: true

require_relative 'lib/thor_nested_subcommand/version'

Gem::Specification.new do |spec|
  spec.name = 'thor_nested_subcommand'
  spec.version = ThorNestedSubcommand::VERSION
  spec.authors      = ['Gene M. Angelo, Jr.']
  spec.email        = ['public.gma@gmail.com']

  spec.summary      = 'A workaround for the Thor gem bug that displays nested subcommand help incorrectly.'
  spec.description  = <<-DESC
    `ThorNestedSubcommand` is a Ruby gem that provides a workaround for the
    Thor gem (https://rubygems.org/gems/thor) bug that displays nested subcommand
    help incorrectly. Simply include the `ThorNestedSubcommand` module in your Thor
    nested subcommand, and provide a simple class method to return what Thor help
    should be displaying, and that's it.
  DESC
  spec.homepage = 'https://github.com/gangelo/thor_nested_subcommand'
  spec.license = 'MIT'
  spec.required_ruby_version = '>= 3.0.1'

  # spec.metadata["allowed_push_host"] = "TODO: Set to your gem server 'https://example.com'"

  spec.metadata['homepage_uri'] = spec.homepage
  spec.metadata['source_code_uri'] = spec.homepage
  spec.metadata['changelog_uri'] = 'https://github.com/gangelo/thor_nested_subcommand/blob/main/CHANGELOG.md'

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files = Dir.chdir(File.expand_path(__dir__)) do
    `git ls-files -z`.split("\x0").reject do |f|
      (f == __FILE__) || f.match(%r{\A(?:(?:test|spec|features)/|\.(?:git|travis|circleci)|appveyor)})
    end
  end
  spec.bindir = 'exe'
  spec.executables = spec.files.grep(%r{\Aexe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  # Uncomment to register a new dependency of your gem
  # spec.add_dependency "example-gem", "~> 1.0"

  # For more information and examples about making a new gem, checkout our
  # guide at: https://bundler.io/guides/creating_gem.html
  spec.metadata['rubygems_mfa_required'] = 'true'
end
