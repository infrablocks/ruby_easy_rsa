require 'spec_helper'

require_relative '../support/shared_examples/global_config'
require_relative '../support/shared_examples/ssl_config'

describe RubyEasyRSA::Commands::Revoke do
  before(:each) do
    RubyEasyRSA.configure do |config|
      config.binary = 'path/to/binary'
    end
  end

  after(:each) do
    RubyEasyRSA.reset!
  end

  it 'calls the easyrsa revoke command' do
    command = subject.class.new(binary: 'easyrsa')

    expect(Open4).to(
        receive(:spawn)
            .with('easyrsa revoke', any_args))

    command.execute
  end

  it 'defaults to the configured binary when none provided' do
    command = subject.class.new

    expect(Open4).to(
        receive(:spawn)
            .with('path/to/binary revoke', any_args))

    command.execute
  end

  it_behaves_like("a command with global config",
      "revoke",
      ["some_important_thing"],
      filename_base: "some_important_thing")
  it_behaves_like("a command with ssl config",
      "revoke",
      ["some_important_thing"],
      filename_base: "some_important_thing")
end
