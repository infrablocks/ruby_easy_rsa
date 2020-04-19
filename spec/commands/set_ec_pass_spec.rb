require 'spec_helper'

require_relative '../support/shared_examples/global_config'
require_relative '../support/shared_examples/ssl_config'
require_relative '../support/shared_examples/encrypt_key_config'

describe RubyEasyRSA::Commands::SetECPass do
  before(:each) do
    RubyEasyRSA.configure do |config|
      config.binary = 'path/to/binary'
    end
  end

  after(:each) do
    RubyEasyRSA.reset!
  end

  it 'calls the easyrsa set-ec-pass command with the filename base' do
    filename_base = 'some_important_thing'
    command = subject.class.new(binary: 'easyrsa')

    expect(Open4).to(
        receive(:spawn)
            .with('easyrsa set-ec-pass some_important_thing',
                any_args))

    command.execute(
        filename_base: filename_base)
  end

  it 'defaults to the configured binary when none provided' do
    filename_base = 'some_important_thing'
    command = subject.class.new

    expect(Open4).to(
        receive(:spawn)
            .with('path/to/binary set-ec-pass some_important_thing',
                any_args))

    command.execute(
        filename_base: filename_base)
  end

  it_behaves_like("a command with global config",
      "set-ec-pass",
      ["some_important_thing"],
      filename_base: "some_important_thing")
  it_behaves_like("a command with ssl config",
      "set-ec-pass",
      ["some_important_thing"],
      filename_base: "some_important_thing")
  it_behaves_like("a command with encrypt key config",
      "set-ec-pass",
      ["some_important_thing"],
      filename_base: "some_important_thing")

  it 'includes the file argument when file is true' do
    filename_base = 'some_important_thing'
    command = subject.class.new

    expect(Open4).to(
        receive(:spawn)
            .with('path/to/binary set-ec-pass some_important_thing file',
                any_args))

    command.execute(
        filename_base: filename_base,
        file: true)
  end

  it 'does not include the file argument when file is false' do
    filename_base = 'some_important_thing'
    command = subject.class.new

    expect(Open4).to(
        receive(:spawn)
            .with('path/to/binary set-ec-pass some_important_thing',
                any_args))

    command.execute(
        filename_base: filename_base,
        file: false)
  end
end
