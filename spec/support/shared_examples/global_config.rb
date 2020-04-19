shared_examples "a command with global config" do |command_name, arguments = [], options = {}|
  let(:argument_string) do
    arguments.empty? ? "" : " #{arguments.join(" ")}"
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
end
