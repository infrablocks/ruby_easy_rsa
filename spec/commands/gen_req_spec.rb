require 'spec_helper'

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
    command = RubyEasyRSA::Commands::GenReq.new(binary: 'easyrsa')

    expect(Open4).to(
        receive(:spawn)
            .with('easyrsa gen-req some_important_thing', any_args))

    command.execute(
        filename_base: filename_base)
  end

  it 'defaults to the configured binary when none provided' do
    filename_base = 'some_important_thing'
    command = RubyEasyRSA::Commands::GenReq.new

    expect(Open4).to(
        receive(:spawn)
            .with('path/to/binary gen-req some_important_thing', any_args))

    command.execute(
        filename_base: filename_base)
  end

  it 'uses the provided PKI directory when specified' do
    filename_base = 'some_important_thing'
    pki_directory = "./some/pki/directory"

    command = RubyEasyRSA::Commands::GenReq.new

    expect(Open4).to(
        receive(:spawn)
            .with('path/to/binary --pki-dir=./some/pki/directory ' +
                'gen-req some_important_thing',
                any_args))

    command.execute(
        pki_directory: pki_directory,
        filename_base: filename_base)
  end

  it 'uses the provided CA expiration time when specified' do
    filename_base = 'some_important_thing'
    expires_in_days = "90"

    command = RubyEasyRSA::Commands::GenReq.new

    expect(Open4).to(
        receive(:spawn)
            .with('path/to/binary --days=90 gen-req some_important_thing',
                any_args))

    command.execute(
        expires_in_days: expires_in_days,
        filename_base: filename_base)
  end

  it 'uses the provided digest when specified' do
    filename_base = 'some_important_thing'
    digest = 'sha512'

    command = RubyEasyRSA::Commands::GenReq.new

    expect(Open4).to(
        receive(:spawn)
            .with('path/to/binary --digest=sha512 gen-req some_important_thing',
                any_args))

    command.execute(
        digest: digest,
        filename_base: filename_base)
  end

  it 'uses the provided distinguished name mode when specified' do
    filename_base = 'some_important_thing'
    distinguished_name_mode = 'org'

    command = RubyEasyRSA::Commands::GenReq.new

    expect(Open4).to(
        receive(:spawn)
            .with('path/to/binary --dn-mode=org gen-req some_important_thing',
                any_args))

    command.execute(
        distinguished_name_mode: distinguished_name_mode,
        filename_base: filename_base)
  end

  it 'uses the provided common name when specified' do
    filename_base = 'some_important_thing'
    common_name = 'server.example.com'

    command = RubyEasyRSA::Commands::GenReq.new

    expect(Open4).to(
        receive(:spawn)
            .with('path/to/binary --req-cn="server.example.com" ' +
                'gen-req some_important_thing',
                any_args))

    command.execute(
        common_name: common_name,
        filename_base: filename_base)
  end

  it 'uses the provided country when specified' do
    filename_base = 'some_important_thing'
    country = 'GB'

    command = RubyEasyRSA::Commands::GenReq.new

    expect(Open4).to(
        receive(:spawn)
            .with('path/to/binary --req-c="GB" gen-req some_important_thing',
                any_args))

    command.execute(
        country: country,
        filename_base: filename_base)
  end

  it 'uses the provided province when specified' do
    filename_base = 'some_important_thing'
    province = 'Greater London'

    command = RubyEasyRSA::Commands::GenReq.new

    expect(Open4).to(
        receive(:spawn)
            .with('path/to/binary --req-st="Greater London" ' +
                'gen-req some_important_thing',
                any_args))

    command.execute(
        province: province,
        filename_base: filename_base)
  end

  it 'uses the provided city when specified' do
    filename_base = 'some_important_thing'
    city = 'London'

    command = RubyEasyRSA::Commands::GenReq.new

    expect(Open4).to(
        receive(:spawn)
            .with('path/to/binary --req-city="London" ' +
                'gen-req some_important_thing',
                any_args))

    command.execute(
        city: city,
        filename_base: filename_base)
  end

  it 'uses the provided organisation when specified' do
    filename_base = 'some_important_thing'
    organisation = 'Company Ltd.'

    command = RubyEasyRSA::Commands::GenReq.new

    expect(Open4).to(
        receive(:spawn)
            .with('path/to/binary --req-org="Company Ltd." ' +
                'gen-req some_important_thing',
                any_args))

    command.execute(
        organisation: organisation,
        filename_base: filename_base)
  end

  it 'uses the provided organisational unit when specified' do
    filename_base = 'some_important_thing'
    organisational_unit = 'Finance'

    command = RubyEasyRSA::Commands::GenReq.new

    expect(Open4).to(
        receive(:spawn)
            .with('path/to/binary --req-ou="Finance" ' +
                'gen-req some_important_thing',
                any_args))

    command.execute(
        organisational_unit: organisational_unit,
        filename_base: filename_base)
  end

  it 'uses the provided email when specified' do
    filename_base = 'some_important_thing'
    email = 'someone@example.com'

    command = RubyEasyRSA::Commands::GenReq.new

    expect(Open4).to(
        receive(:spawn)
            .with('path/to/binary --req-email=someone@example.com ' +
                'gen-req some_important_thing',
                any_args))

    command.execute(
        email: email,
        filename_base: filename_base)
  end

  it 'uses the provided openssl binary when specified' do
    filename_base = 'some_important_thing'
    openssl_binary = "./vendor/openssl/bin/openssl"

    command = RubyEasyRSA::Commands::GenReq.new

    expect(Open4).to(
        receive(:spawn)
            .with('EASYRSA_OPENSSL="./vendor/openssl/bin/openssl" ' +
                'path/to/binary gen-req some_important_thing',
                any_args))

    command.execute(
        openssl_binary: openssl_binary,
        filename_base: filename_base)
  end

  it 'uses the provided ssl configuration when specified' do
    filename_base = 'some_important_thing'
    ssl_configuration = "./vendor/easyrsa/openssl-easyrsa.cnf"

    command = RubyEasyRSA::Commands::GenReq.new

    expect(Open4).to(
        receive(:spawn)
            .with('EASYRSA_SSL_CONF="./vendor/easyrsa/openssl-easyrsa.cnf" ' +
                'path/to/binary gen-req some_important_thing',
                any_args))

    command.execute(
        ssl_configuration: ssl_configuration,
        filename_base: filename_base)
  end

  it 'uses the provided safe configuration when specified' do
    filename_base = 'some_important_thing'
    safe_configuration = "./vendor/easyrsa/safessl-easyrsa.cnf"

    command = RubyEasyRSA::Commands::GenReq.new

    expect(Open4).to(
        receive(:spawn)
            .with('EASYRSA_SAFE_CONF="./vendor/easyrsa/safessl-easyrsa.cnf" ' +
                'path/to/binary gen-req some_important_thing',
                any_args))

    command.execute(
        safe_configuration: safe_configuration,
        filename_base: filename_base)
  end

  it 'uses the provided vars when specified' do
    filename_base = 'some_important_thing'
    vars = "./pki/vars"

    command = RubyEasyRSA::Commands::GenReq.new

    expect(Open4).to(
        receive(:spawn)
            .with('path/to/binary --vars=./pki/vars ' +
                'gen-req some_important_thing',
                any_args))

    command.execute(
        vars: vars,
        filename_base: filename_base)
  end

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

  it 'uses the provided algorithm when specified' do
    filename_base = 'some_important_thing'
    algorithm = "ec"

    command = RubyEasyRSA::Commands::GenReq.new

    expect(Open4).to(
        receive(:spawn)
            .with('path/to/binary --use-algo=ec gen-req some_important_thing',
                any_args))

    command.execute(
        algorithm: algorithm,
        filename_base: filename_base)
  end

  it 'uses the provided curve when specified' do
    filename_base = 'some_important_thing'
    curve = "sect571k1"

    command = RubyEasyRSA::Commands::GenReq.new

    expect(Open4).to(
        receive(:spawn)
            .with('path/to/binary --curve=sect571k1 ' +
                'gen-req some_important_thing',
                any_args))

    command.execute(
        curve: curve,
        filename_base: filename_base)
  end

  it 'uses the provided ec directory when specified' do
    filename_base = 'some_important_thing'
    ec_directory = "./ec"

    command = RubyEasyRSA::Commands::GenReq.new

    expect(Open4).to(
        receive(:spawn)
            .with('EASYRSA_EC_DIR="./ec" path/to/binary ' +
                'gen-req some_important_thing',
                any_args))

    command.execute(
        ec_directory: ec_directory,
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
