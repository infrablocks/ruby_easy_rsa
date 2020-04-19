shared_examples "a command with global config" do |command_name, arguments = [], options = {}|
  let(:argument_string) do
    arguments.empty? ? "" : " #{arguments.join(" ")}"
  end

  it 'uses the provided PKI directory when specified' do
    pki_directory = "./some/pki/directory"

    command = subject.class.new

    expect(Open4).to(
        receive(:spawn)
            .with("path/to/binary --pki-dir=./some/pki/directory " +
                "#{command_name}#{argument_string}",
                any_args))

    command.execute(
        options.merge(pki_directory: pki_directory))
  end

  it 'uses the provided extensions directory when specified' do
    extensions_directory = "./pki/extensions"

    command = subject.class.new

    expect(Open4).to(
        receive(:spawn)
            .with("EASYRSA_EXT_DIR=\"./pki/extensions\" path/to/binary " +
                "#{command_name}#{argument_string}",
                any_args))

    command.execute(
        options.merge(extensions_directory: extensions_directory))
  end

  it 'uses the provided openssl binary when specified' do
    openssl_binary = "./vendor/openssl/bin/openssl"

    command = subject.class.new

    expect(Open4).to(
        receive(:spawn)
            .with('EASYRSA_OPENSSL="./vendor/openssl/bin/openssl" ' +
                "path/to/binary #{command_name}#{argument_string}",
                any_args))

    command.execute(
        options.merge(openssl_binary: openssl_binary))
  end

  it 'uses the provided ssl configuration when specified' do
    ssl_configuration = "./vendor/easyrsa/openssl-easyrsa.cnf"

    command = subject.class.new

    expect(Open4).to(
        receive(:spawn)
            .with('EASYRSA_SSL_CONF="./vendor/easyrsa/openssl-easyrsa.cnf" ' +
                "path/to/binary #{command_name}#{argument_string}",
                any_args))

    command.execute(
        options.merge(ssl_configuration: ssl_configuration))
  end

  it 'uses the provided safe configuration when specified' do
    safe_configuration = "./vendor/easyrsa/safessl-easyrsa.cnf"

    command = subject.class.new

    expect(Open4).to(
        receive(:spawn)
            .with('EASYRSA_SAFE_CONF="./vendor/easyrsa/safessl-easyrsa.cnf" ' +
                "path/to/binary #{command_name}#{argument_string}",
                any_args))

    command.execute(
        options.merge(safe_configuration: safe_configuration))
  end

  it 'uses the provided vars when specified' do
    vars = "./pki/vars"

    command = subject.class.new

    expect(Open4).to(
        receive(:spawn)
            .with("path/to/binary --vars=./pki/vars " +
                "#{command_name}#{argument_string}",
                any_args))

    command.execute(
        options.merge(vars: vars))
  end

  it 'passes the batch flag when batch is true' do
    batch = true

    command = subject.class.new

    expect(Open4).to(
        receive(:spawn)
            .with("path/to/binary --batch " +
                "#{command_name}#{argument_string}",
                any_args))

    command.execute(
        options.merge(batch: batch))
  end

  it 'does not pass the batch flag when batch is false' do
    batch = false

    command = subject.class.new

    expect(Open4).to(
        receive(:spawn)
            .with("path/to/binary " +
                "#{command_name}#{argument_string}",
                any_args))

    command.execute(
        options.merge(batch: batch))
  end
end
