require 'spec_helper'

describe RubyEasyRSA::Commands::GenDH do
  before(:each) do
    RubyEasyRSA.configure do |config|
      config.binary = 'path/to/binary'
    end
  end

  after(:each) do
    RubyEasyRSA.reset!
  end

  it 'calls the easyrsa gen-dh command' do
    command = RubyEasyRSA::Commands::GenDH.new(binary: 'easyrsa')

    expect(Open4).to(
        receive(:spawn)
            .with('easyrsa gen-dh', any_args))

    command.execute
  end

  it 'defaults to the configured binary when none provided' do
    command = RubyEasyRSA::Commands::GenDH.new

    expect(Open4).to(
        receive(:spawn)
            .with('path/to/binary gen-dh', any_args))

    command.execute
  end

  it 'uses the provided PKI directory when specified' do
    pki_directory = "./some/pki/directory"

    command = RubyEasyRSA::Commands::GenDH.new

    expect(Open4).to(
        receive(:spawn)
            .with('path/to/binary --pki-dir=./some/pki/directory gen-dh',
                any_args))

    command.execute(
        pki_directory: pki_directory)
  end

  it 'uses the provided CA expiration time when specified' do
    expires_in_days = "90"

    command = RubyEasyRSA::Commands::GenDH.new

    expect(Open4).to(
        receive(:spawn)
            .with('path/to/binary --days=90 gen-dh',
                any_args))

    command.execute(
        expires_in_days: expires_in_days)
  end

  it 'uses the provided digest when specified' do
    digest = 'sha512'

    command = RubyEasyRSA::Commands::GenDH.new

    expect(Open4).to(
        receive(:spawn)
            .with('path/to/binary --digest=sha512 gen-dh',
                any_args))

    command.execute(
        digest: digest)
  end

  it 'uses the provided distinguished name mode when specified' do
    distinguished_name_mode = 'org'

    command = RubyEasyRSA::Commands::GenDH.new

    expect(Open4).to(
        receive(:spawn)
            .with('path/to/binary --dn-mode=org gen-dh',
                any_args))

    command.execute(
        distinguished_name_mode: distinguished_name_mode)
  end

  it 'uses the provided common name when specified' do
    common_name = 'server.example.com'

    command = RubyEasyRSA::Commands::GenDH.new

    expect(Open4).to(
        receive(:spawn)
            .with('path/to/binary --req-cn="server.example.com" gen-dh',
                any_args))

    command.execute(
        common_name: common_name)
  end

  it 'uses the provided country when specified' do
    country = 'GB'

    command = RubyEasyRSA::Commands::GenDH.new

    expect(Open4).to(
        receive(:spawn)
            .with('path/to/binary --req-c="GB" gen-dh',
                any_args))

    command.execute(
        country: country)
  end

  it 'uses the provided province when specified' do
    province = 'Greater London'

    command = RubyEasyRSA::Commands::GenDH.new

    expect(Open4).to(
        receive(:spawn)
            .with('path/to/binary --req-st="Greater London" gen-dh',
                any_args))

    command.execute(
        province: province)
  end

  it 'uses the provided city when specified' do
    city = 'London'

    command = RubyEasyRSA::Commands::GenDH.new

    expect(Open4).to(
        receive(:spawn)
            .with('path/to/binary --req-city="London" gen-dh',
                any_args))

    command.execute(
        city: city)
  end

  it 'uses the provided organisation when specified' do
    organisation = 'Company Ltd.'

    command = RubyEasyRSA::Commands::GenDH.new

    expect(Open4).to(
        receive(:spawn)
            .with('path/to/binary --req-org="Company Ltd." gen-dh',
                any_args))

    command.execute(
        organisation: organisation)
  end

  it 'uses the provided organisational unit when specified' do
    organisational_unit = 'Finance'

    command = RubyEasyRSA::Commands::GenDH.new

    expect(Open4).to(
        receive(:spawn)
            .with('path/to/binary --req-ou="Finance" gen-dh',
                any_args))

    command.execute(
        organisational_unit: organisational_unit)
  end

  it 'uses the provided email when specified' do
    email = 'someone@example.com'

    command = RubyEasyRSA::Commands::GenDH.new

    expect(Open4).to(
        receive(:spawn)
            .with('path/to/binary --req-email=someone@example.com gen-dh',
                any_args))

    command.execute(
        email: email)
  end

  it 'uses the provided openssl binary when specified' do
    openssl_binary = "./vendor/openssl/bin/openssl"

    command = RubyEasyRSA::Commands::GenDH.new

    expect(Open4).to(
        receive(:spawn)
            .with('EASYRSA_OPENSSL="./vendor/openssl/bin/openssl" ' +
                'path/to/binary gen-dh',
                any_args))

    command.execute(
        openssl_binary: openssl_binary)
  end

  it 'uses the provided ssl configuration when specified' do
    ssl_configuration = "./vendor/easyrsa/openssl-easyrsa.cnf"

    command = RubyEasyRSA::Commands::GenDH.new

    expect(Open4).to(
        receive(:spawn)
            .with('EASYRSA_SSL_CONF="./vendor/easyrsa/openssl-easyrsa.cnf" ' +
                'path/to/binary gen-dh',
                any_args))

    command.execute(
        ssl_configuration: ssl_configuration)
  end

  it 'uses the provided safe configuration when specified' do
    safe_configuration = "./vendor/easyrsa/safessl-easyrsa.cnf"

    command = RubyEasyRSA::Commands::GenDH.new

    expect(Open4).to(
        receive(:spawn)
            .with('EASYRSA_SAFE_CONF="./vendor/easyrsa/safessl-easyrsa.cnf" ' +
                'path/to/binary gen-dh',
                any_args))

    command.execute(
        safe_configuration: safe_configuration)
  end

  it 'uses the provided vars when specified' do
    vars = "./pki/vars"

    command = RubyEasyRSA::Commands::GenDH.new

    expect(Open4).to(
        receive(:spawn)
            .with('path/to/binary --vars=./pki/vars gen-dh',
                any_args))

    command.execute(
        vars: vars)
  end
end
