require 'spec_helper'

require_relative '../support/shared_examples/global_config'
require_relative '../support/shared_examples/algorithm_config'
require_relative '../support/shared_examples/ssl_config'
require_relative '../support/shared_examples/extra_extensions_config'
require_relative '../support/shared_examples/encrypt_key_config'

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
  it_behaves_like("a command with extra extensions config",
      "gen-req",
      ["some_important_thing"],
      filename_base: "some_important_thing")
  it_behaves_like("a command with encrypt key config",
      "gen-req",
      ["some_important_thing"],
      filename_base: "some_important_thing")
end
