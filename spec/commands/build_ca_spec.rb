require 'spec_helper'

require_relative '../support/shared_examples/global_config'
require_relative '../support/shared_examples/algorithm_config'
require_relative '../support/shared_examples/ssl_config'

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

  it 'uses the provided batch flag when specified' do
    batch = true

    command = subject.class.new

    expect(Open4).to(
        receive(:spawn)
            .with('path/to/binary --batch build-ca',
                any_args))

    command.execute(
        batch: batch)
  end

  it 'passes the nopass argument when encrypt_key is false' do
    encrypt_key = false

    command = subject.class.new

    expect(Open4).to(
        receive(:spawn)
            .with('path/to/binary build-ca nopass',
                any_args))

    command.execute(
        encrypt_key: encrypt_key)
  end

  it 'does not pass the nopass argument when encrypt_key is true' do
    encrypt_key = true

    command = subject.class.new

    expect(Open4).to(
        receive(:spawn)
            .with('path/to/binary build-ca',
                any_args))

    command.execute(
        encrypt_key: encrypt_key)
  end

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
