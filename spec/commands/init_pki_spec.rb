require 'spec_helper'

describe RubyEasyRSA::Commands::InitPKI do
  before(:each) do
    RubyEasyRSA.configure do |config|
      config.binary = 'path/to/binary'
    end
  end

  after(:each) do
    RubyEasyRSA.reset!
  end

  it 'calls the easyrsa init-pki command' do
    command = RubyEasyRSA::Commands::InitPKI.new(binary: 'easyrsa')

    expect(Open4).to(
        receive(:spawn)
            .with('easyrsa init-pki', any_args))

    command.execute
  end

  it 'defaults to the configured binary when none provided' do
    command = RubyEasyRSA::Commands::InitPKI.new

    expect(Open4).to(
        receive(:spawn)
            .with('path/to/binary init-pki', any_args))

    command.execute
  end

  it 'uses the provided PKI directory when specified' do
    pki_directory = "./some/pki/directory"

    command = RubyEasyRSA::Commands::InitPKI.new

    expect(Open4).to(
        receive(:spawn)
            .with('path/to/binary --pki-dir=./some/pki/directory init-pki',
                any_args))

    command.execute(
        pki_directory: pki_directory)
  end

  it 'uses the provided openssl binary when specified' do
    openssl_binary = "./vendor/openssl/bin/openssl"

    command = RubyEasyRSA::Commands::InitPKI.new

    expect(Open4).to(
        receive(:spawn)
            .with('EASYRSA_OPENSSL="./vendor/openssl/bin/openssl" ' +
                'path/to/binary init-pki',
                any_args))

    command.execute(
        openssl_binary: openssl_binary)
  end

  it 'uses the provided ssl configuration when specified' do
    ssl_configuration = "./vendor/easyrsa/openssl-easyrsa.cnf"

    command = RubyEasyRSA::Commands::InitPKI.new

    expect(Open4).to(
        receive(:spawn)
            .with('EASYRSA_SSL_CONF="./vendor/easyrsa/openssl-easyrsa.cnf" ' +
                'path/to/binary init-pki',
                any_args))

    command.execute(
        ssl_configuration: ssl_configuration)
  end

  it 'uses the provided safe configuration when specified' do
    safe_configuration = "./vendor/easyrsa/safessl-easyrsa.cnf"

    command = RubyEasyRSA::Commands::InitPKI.new

    expect(Open4).to(
        receive(:spawn)
            .with('EASYRSA_SAFE_CONF="./vendor/easyrsa/safessl-easyrsa.cnf" ' +
                'path/to/binary init-pki',
                any_args))

    command.execute(
        safe_configuration: safe_configuration)
  end

  it 'uses the provided vars when specified' do
    vars = "./pki/vars"

    command = RubyEasyRSA::Commands::InitPKI.new

    expect(Open4).to(
        receive(:spawn)
            .with('path/to/binary --vars=./pki/vars init-pki',
                any_args))

    command.execute(
        vars: vars)
  end
end
