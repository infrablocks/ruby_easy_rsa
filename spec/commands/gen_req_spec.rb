require 'spec_helper'

require_relative '../support/shared_examples/global_config'
require_relative '../support/shared_examples/algorithm_config'
require_relative '../support/shared_examples/ssl_config'

describe RubyEasyRSA::Commands::GenReq do
  before(:each) do
    RubyEasyRSA.configure do |config|
      config.binary = 'path/to/binary'
    end
  end

  after(:each) do
    RubyEasyRSA.reset!
  end

  it 'calls the easyrsa gen-req command with the filename base' do
    filename_base = 'some_important_thing'
    command = subject.class.new(binary: 'easyrsa')

    expect(Open4).to(
        receive(:spawn)
            .with('easyrsa gen-req some_important_thing', any_args))

    command.execute(
        filename_base: filename_base)
  end

  it 'defaults to the configured binary when none provided' do
    filename_base = 'some_important_thing'
    command = subject.class.new

    expect(Open4).to(
        receive(:spawn)
            .with('path/to/binary gen-req some_important_thing', any_args))

    command.execute(
        filename_base: filename_base)
  end

  it_behaves_like("a command with global config",
      "gen-req",
      ["some_important_thing"],
      filename_base: "some_important_thing")
  it_behaves_like("a command with algorithm config",
      "gen-req",
      ["some_important_thing"],
      filename_base: "some_important_thing")
  it_behaves_like("a command with ssl config",
      "gen-req",
      ["some_important_thing"],
      filename_base: "some_important_thing")

  it 'uses the provided batch flag when specified' do
    filename_base = 'some_important_thing'
    batch = true

    command = RubyEasyRSA::Commands::GenReq.new

    expect(Open4).to(
        receive(:spawn)
            .with('path/to/binary --batch gen-req some_important_thing',
                any_args))

    command.execute(
        batch: batch,
        filename_base: filename_base)

  end

  it 'passes the nopass argument when encrypt_key is false' do
    filename_base = 'some_important_thing'
    encrypt_key = false

    command = RubyEasyRSA::Commands::GenReq.new

    expect(Open4).to(
        receive(:spawn)
            .with('path/to/binary gen-req some_important_thing nopass',
                any_args))

    command.execute(
        encrypt_key: encrypt_key,
        filename_base: filename_base)
  end

  it 'does not pass the nopass argument when encrypt_key is true' do
    filename_base = 'some_important_thing'
    encrypt_key = true

    command = RubyEasyRSA::Commands::GenReq.new

    expect(Open4).to(
        receive(:spawn)
            .with('path/to/binary gen-req some_important_thing',
                any_args))

    command.execute(
        encrypt_key: encrypt_key,
        filename_base: filename_base)
  end
end
