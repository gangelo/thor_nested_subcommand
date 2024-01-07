[![Ruby](https://github.com/gangelo/thor_nested_subcommand/actions/workflows/ruby.yml/badge.svg?refresh=1)](https://github.com/gangelo/thor_nested_subcommand/actions/workflows/ruby.yml)
[![GitHub version](http://badge.fury.io/gh/gangelo%2Fthor_nested_subcommand.svg?refresh=3)](https://badge.fury.io/gh/gangelo%2Fthor_nested_subcommand)
[![Gem Version](https://badge.fury.io/rb/thor_nested_subcommand.svg?refresh=3)](https://badge.fury.io/rb/thor_nested_subcommand)
[![](http://ruby-gem-downloads-badge.herokuapp.com/thor_nested_subcommand?type=total)](http://www.rubydoc.info/gems/thor_nested_subcommand/)
[![Documentation](http://img.shields.io/badge/docs-rdoc.info-blue.svg)](http://www.rubydoc.info/gems/thor_nested_subcommand/)
[![Report Issues](https://img.shields.io/badge/report-issues-red.svg)](https://github.com/gangelo/thor_nested_subcommand/issues)
[![License](http://img.shields.io/badge/license-MIT-yellowgreen.svg)](#license)

# ThorNestedSubcommand

`ThorNestedSubcommand` is a Ruby gem that provides a workaround for the [Thor gem](https://rubygems.org/gems/thor) bug that displays nested subcommand help incorrectly. Simply include the `ThorNestedSubcommand` module in your Thor nested subcommand, and provide a simple class method to return what Thor help shoul be displaying, and that's it.

## Usage

First, follow instructions for [installation](#installation).

Secondly, do the following in your Thor `subcommand`:
* include the `ThorNestedSubcommand`.
* Add a `.base_name` class method and return the base name for the nested `subcommand` you need Thor help to display.

For example:

```ruby
require 'thor'
require 'thor_nested_subcommand'

class Command < ::Thor
  desc 'sub_command SUBCOMMAND', 'sub command'
  subcommand :sub_command, SubCommand
end

class SubCommand < ::Thor
    desc 'nested_sub_command SUBCOMMAND', 'nested sub command'
    subcommand :nested_sub_command, NestedSubCommand
end

# Thor help breaks because this is a nested subcommand.
class NestedSubCommand < ::Thor
  # Include this:
  include ThorNestedSubcommand

  class << self
    # Add this:
    def base_usage
      # Return what Thor shoud be displaying for your nested subcommand:
      'sub_command nested_sub_command'
    end
  end

  desc 'test', 'test the command'
  def test
    puts 'test'
  end
end
```

That's it. Disaster averted:

```shell
$ command sub_command help nested_sub_command
> Commands:
>  command sub_command nested_sub_command help [COMMAND]   # Describe subcommands or one specific subcommand
>  command sub_command nested_sub_command test             # test sub sub command
```

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'thor_nested_subcommand'
```

And then execute:

    $ bundle install

Or install it yourself as:

    $ gem install thor_nested_subcommand

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and the created tag, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/thor_nested_subcommand. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [code of conduct](https://github.com/[USERNAME]/thor_nested_subcommand/blob/main/CODE_OF_CONDUCT.md).

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the ThorNestedSubcommand project's codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/[USERNAME]/thor_nested_subcommand/blob/main/CODE_OF_CONDUCT.md).
