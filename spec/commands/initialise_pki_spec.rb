require 'spec_helper'

describe RubyEasyRSA::Commands::InitialisePKI do
  before(:each) do
    RubyEasyRSA.configure do |config|
      config.binary = 'path/to/binary'
    end
  end

  after(:each) do
    RubyEasyRSA.reset!
  end

  it 'calls the easyrsa init-pki command' do
    command = RubyEasyRSA::Commands::InitialisePKI.new(binary: 'easyrsa')

    expect(Open4).to(
        receive(:spawn)
            .with('easyrsa init-pki', any_args))

    command.execute
  end

  it 'defaults to the configured binary when none provided' do
    command = RubyEasyRSA::Commands::InitialisePKI.new

    expect(Open4).to(
        receive(:spawn)
            .with('path/to/binary init-pki', any_args))

    command.execute
  end

  it 'uses the provided PKI directory when specified' do
    pki_directory = "./some/pki/directory"

    command = RubyEasyRSA::Commands::InitialisePKI.new

    expect(Open4).to(
        receive(:spawn)
            .with('path/to/binary init-pki --pki-dir=./some/pki/directory',
                any_args))

    command.execute(
        pki_directory: pki_directory)
  end
end
