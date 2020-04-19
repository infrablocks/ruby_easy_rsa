require 'spec_helper'

require_relative '../support/shared_examples/global_config'
require_relative '../support/shared_examples/algorithm_config'
require_relative '../support/shared_examples/ssl_config'
require_relative '../support/shared_examples/encrypt_key_config'

describe RubyEasyRSA::Commands::BuildCA do
  before(:each) do
    RubyEasyRSA.configure do |config|
      config.binary = 'path/to/binary'
    end
  end

  after(:each) do
    RubyEasyRSA.reset!
  end

  it 'calls the easyrsa build-ca command' do
    command = subject.class.new(binary: 'easyrsa')

    expect(Open4).to(
        receive(:spawn)
            .with('easyrsa build-ca', any_args))

    command.execute
  end

  it 'defaults to the configured binary when none provided' do
    command = subject.class.new

    expect(Open4).to(
        receive(:spawn)
            .with('path/to/binary build-ca', any_args))

    command.execute
  end

  it_behaves_like "a command with global config", "build-ca"
  it_behaves_like "a command with algorithm config", "build-ca"
  it_behaves_like "a command with ssl config", "build-ca"
  it_behaves_like "a command with encrypt key config", "build-ca"

  it 'passes the subca argument when sub_ca is true' do
    sub_ca = true

    command = subject.class.new

    expect(Open4).to(
        receive(:spawn)
            .with('path/to/binary build-ca subca',
                any_args))

    command.execute(
        sub_ca: sub_ca)
  end

  it 'does not pass the subca argument when sub_ca is false' do
    sub_ca = false

    command = subject.class.new

    expect(Open4).to(
        receive(:spawn)
            .with('path/to/binary build-ca',
                any_args))

    command.execute(
        sub_ca: sub_ca)
  end
end
