# frozen_string_literal: true

require "bundler/gem_tasks"
require "rspec/core/rake_task"

RSpec::Core::RakeTask.new(:spec)
# RSpec::Core::RakeTask.new(:spec) do |t|
#   t.pattern = 'spec/**{,/*/**}/*_spec.rb' # Define the pattern for RSpec
#   t.rspec_opts = [] # You can specify additional RSpec options here
# end

require "rubocop/rake_task"

RuboCop::RakeTask.new

task default: %i[spec rubocop]
