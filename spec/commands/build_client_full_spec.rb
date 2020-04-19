require 'spec_helper'

require_relative '../support/shared_examples/global_config'
require_relative '../support/shared_examples/algorithm_config'
require_relative '../support/shared_examples/ssl_config'
require_relative '../support/shared_examples/extra_extensions_config'
require_relative '../support/shared_examples/netscape_extensions_config'

describe RubyEasyRSA::Commands::BuildClientFull do
  before(:each) do
    RubyEasyRSA.configure do |config|
      config.binary = 'path/to/binary'
    end
  end

  after(:each) do
    RubyEasyRSA.reset!
  end

  it 'calls the easyrsa build-client-full command with the filename base' do
    filename_base = 'some_important_thing'
    command = subject.class.new(binary: 'easyrsa')

    expect(Open4).to(
        receive(:spawn)
            .with('easyrsa build-client-full some_important_thing',
                any_args))

    command.execute(
        filename_base: filename_base)
  end

  it 'defaults to the configured binary when none provided' do
    filename_base = 'some_important_thing'
    command = subject.class.new

    expect(Open4).to(
        receive(:spawn)
            .with('path/to/binary build-client-full some_important_thing',
                any_args))

    command.execute(
        filename_base: filename_base)
  end

  it_behaves_like("a command with global config",
      "build-client-full",
      ["some_important_thing"],
      filename_base: "some_important_thing")
  it_behaves_like("a command with algorithm config",
      "build-client-full",
      ["some_important_thing"],
      filename_base: "some_important_thing")
  it_behaves_like("a command with ssl config",
      "build-client-full",
      ["some_important_thing"],
      filename_base: "some_important_thing")
  it_behaves_like("a command with extra extensions config",
      "build-client-full",
      ["some_important_thing"],
      filename_base: "some_important_thing")
  it_behaves_like("a command with netscape extensions config",
      "build-client-full",
      ["some_important_thing"],
      filename_base: "some_important_thing")

  it 'includes the copy-ext switch when copy extensions is true' do
    filename_base = 'some_important_thing'
    command = subject.class.new

    expect(Open4).to(
        receive(:spawn)
            .with(
                'path/to/binary --copy-ext build-client-full ' +
                    'some_important_thing',
                any_args))

    command.execute(
        filename_base: filename_base,
        copy_extensions: true)
  end

  it 'does not include the copy-ext switch when copy extensions is false' do
    filename_base = 'some_important_thing'
    command = subject.class.new

    expect(Open4).to(
        receive(:spawn)
            .with('path/to/binary build-client-full some_important_thing',
                any_args))

    command.execute(
        filename_base: filename_base,
        copy_extensions: false)
  end

  it 'uses the provided sub-CA length' do
    filename_base = 'some_important_thing'
    sub_ca_length = 10
    command = subject.class.new

    expect(Open4).to(
        receive(:spawn)
            .with('path/to/binary --subca-len=10 ' +
                'build-client-full some_important_thing',
                any_args))

    command.execute(
        filename_base: filename_base,
        sub_ca_length: sub_ca_length)
  end
end
