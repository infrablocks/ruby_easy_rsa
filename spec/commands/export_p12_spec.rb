require 'spec_helper'

require_relative '../support/shared_examples/global_config'
require_relative '../support/shared_examples/ssl_config'

describe RubyEasyRSA::Commands::ExportP12 do
  before(:each) do
    RubyEasyRSA.configure do |config|
      config.binary = 'path/to/binary'
    end
  end

  after(:each) do
    RubyEasyRSA.reset!
  end

  it 'calls the easyrsa export-p12 command with the filename base' do
    filename_base = 'some_important_thing'
    command = subject.class.new(binary: 'easyrsa')

    expect(Open4).to(
        receive(:spawn)
            .with('easyrsa export-p12 some_important_thing',
                any_args))

    command.execute(
        filename_base: filename_base)
  end

  it 'defaults to the configured binary when none provided' do
    filename_base = 'some_important_thing'
    command = subject.class.new

    expect(Open4).to(
        receive(:spawn)
            .with('path/to/binary export-p12 some_important_thing',
                any_args))

    command.execute(
        filename_base: filename_base)
  end

  it_behaves_like("a command with global config",
      "export-p12",
      ["some_important_thing"],
      filename_base: "some_important_thing")
  it_behaves_like("a command with ssl config",
      "export-p12",
      ["some_important_thing"],
      filename_base: "some_important_thing")

  it 'does not include the noca argument when include_ca is true' do
    filename_base = 'some_important_thing'
    command = subject.class.new

    expect(Open4).to(
        receive(:spawn)
            .with('path/to/binary export-p12 some_important_thing',
                any_args))

    command.execute(
        filename_base: filename_base,
        include_ca: true)
  end

  it 'includes the noca argument when include_ca is false' do
    filename_base = 'some_important_thing'
    command = subject.class.new

    expect(Open4).to(
        receive(:spawn)
            .with('path/to/binary export-p12 some_important_thing noca',
                any_args))

    command.execute(
        filename_base: filename_base,
        include_ca: false)
  end

  it 'does not include the nokey argument when include_key is true' do
    filename_base = 'some_important_thing'
    command = subject.class.new

    expect(Open4).to(
        receive(:spawn)
            .with('path/to/binary export-p12 some_important_thing',
                any_args))

    command.execute(
        filename_base: filename_base,
        include_key: true)
  end

  it 'includes the nokey argument when include_key is false' do
    filename_base = 'some_important_thing'
    command = subject.class.new

    expect(Open4).to(
        receive(:spawn)
            .with('path/to/binary export-p12 some_important_thing nokey',
                any_args))

    command.execute(
        filename_base: filename_base,
        include_key: false)
  end
end
