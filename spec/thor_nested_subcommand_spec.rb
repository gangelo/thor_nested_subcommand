# frozen_string_literal: true

RSpec.describe ThorNestedSubcommand do
  before do
    ARGV.clear
  end

  let(:sub_command) do
    klass = Class.new(Thor) do
      desc 'sub_sub_command SUBCOMMAND', 'sub sub command'
      subcommand :sub_sub_command, SubSubCommand
    end
    stub_const('SubCommand', klass)
  end

  it 'has a version number' do
    expect(ThorNestedSubcommand::VERSION).not_to be_nil
  end

  context 'when ThorNestedSubcommand is not used' do
    before do
      sub_sub_command
      sub_command
    end

    let!(:sub_sub_command) do
      klass = Class.new(Thor) do
        class << self
          def base_usage
            'sub_command sub_sub_command'
          end
        end

        desc 'test', 'test sub sub command'
        def test
          puts 'test'
        end
      end
      stub_const('SubSubCommand', klass)
    end

    it 'displays the incorrect correct Thor help for nested subcommands' do
      command_help = with_captured_stdout { sub_sub_command.start }
      expect(command_help).not_to include('sub_command sub_sub_command')
    end
  end

  context 'when ThorNestedSubcommand is used' do
    before do
      sub_sub_command
      sub_command
    end

    let(:sub_sub_command) do
      klass = Class.new(Thor) do
        include ThorNestedSubcommand

        class << self
          def base_usage
            'sub_command sub_sub_command'
          end
        end

        desc 'test', 'test sub sub command'
        def test
          puts 'test'
        end
      end
      stub_const('SubSubCommand', klass)
    end

    it 'displays the correct Thor help for nested subcommands' do
      command_help = with_captured_stdout { sub_sub_command.start }
      expect(command_help).to include('rspec sub_command sub_sub_command help [COMMAND]')
        .and include('rspec sub_command sub_sub_command test')
    end
  end

  def with_captured_stdout
    original_stdout = $stdout  # capture previous value of $stdout
    $stdout = StringIO.new     # assign a string buffer to $stdout
    yield                      # perform the body of the user code
    $stdout.string             # return the contents of the string buffer
  ensure
    $stdout = original_stdout  # restore $stdout to its previous value
  end
end
