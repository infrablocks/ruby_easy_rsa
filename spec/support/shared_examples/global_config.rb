# frozen_string_literal: true

shared_examples(
  'a command with global config'
) do |command_name, arguments = [], options = {}|
  let(:argument_string) { arguments.empty? ? '' : " #{arguments.join(' ')}" }
  let(:executor) { Lino::Executors::Mock.new }

  before do
    Lino.configure do |config|
      config.executor = executor
    end
  end

  after do
    Lino.reset!
  end

  it 'uses the provided PKI directory when specified' do
    pki_directory = './some/pki/directory'

    command = described_class.new

    command.execute(
      options.merge(pki_directory:)
    )

    expect(executor.executions.first.command_line.string)
      .to(eq('path/to/binary --pki-dir=./some/pki/directory ' \
             "#{command_name}#{argument_string}"))
  end

  it 'uses the provided extensions directory when specified' do
    extensions_directory = './pki/extensions'

    command = described_class.new

    command.execute(
      options.merge(extensions_directory:)
    )

    expect(executor.executions.first.command_line.string)
      .to(eq('EASYRSA_EXT_DIR="./pki/extensions" path/to/binary ' \
             "#{command_name}#{argument_string}"))
  end

  it 'uses the provided openssl binary when specified' do
    openssl_binary = './vendor/openssl/bin/openssl'

    command = described_class.new

    command.execute(
      options.merge(openssl_binary:)
    )

    expect(executor.executions.first.command_line.string)
      .to(eq('EASYRSA_OPENSSL="./vendor/openssl/bin/openssl" ' \
             "path/to/binary #{command_name}#{argument_string}"))
  end

  it 'uses the provided ssl configuration when specified' do
    ssl_configuration = './vendor/easyrsa/openssl-easyrsa.cnf'

    command = described_class.new

    command.execute(
      options.merge(ssl_configuration:)
    )

    expect(executor.executions.first.command_line.string)
      .to(eq('EASYRSA_SSL_CONF="./vendor/easyrsa/openssl-easyrsa.cnf" ' \
             "path/to/binary #{command_name}#{argument_string}"))
  end

  it 'uses the provided safe configuration when specified' do
    safe_configuration = './vendor/easyrsa/safessl-easyrsa.cnf'

    command = described_class.new

    command.execute(
      options.merge(safe_configuration:)
    )

    expect(executor.executions.first.command_line.string)
      .to(eq('EASYRSA_SAFE_CONF="./vendor/easyrsa/safessl-easyrsa.cnf" ' \
             "path/to/binary #{command_name}#{argument_string}"))
  end

  it 'uses the provided vars when specified' do
    vars = './pki/vars'

    command = described_class.new

    command.execute(
      options.merge(vars:)
    )

    expect(executor.executions.first.command_line.string)
      .to(eq('path/to/binary --vars=./pki/vars ' \
             "#{command_name}#{argument_string}"))
  end

  it 'passes the batch flag when batch is true' do
    batch = true

    command = described_class.new

    command.execute(
      options.merge(batch:)
    )

    expect(executor.executions.first.command_line.string)
      .to(eq('path/to/binary --batch ' \
             "#{command_name}#{argument_string}"))
  end

  it 'does not pass the batch flag when batch is false' do
    batch = false

    command = described_class.new

    command.execute(
      options.merge(batch:)
    )

    expect(executor.executions.first.command_line.string)
      .to(eq('path/to/binary ' \
             "#{command_name}#{argument_string}"))
  end

  it 'uses the provided password spec for passin' do
    input_password = 'pass:1234'

    command = described_class.new

    command.execute(
      options.merge(input_password:)
    )

    expect(executor.executions.first.command_line.string)
      .to(eq('path/to/binary --passin=pass:1234 ' \
             "#{command_name}#{argument_string}"))
  end

  it 'uses the provided password spec for passout' do
    output_password = 'pass:1234'

    command = described_class.new

    command.execute(
      options.merge(output_password:)
    )

    expect(executor.executions.first.command_line.string)
      .to(eq('path/to/binary --passout=pass:1234 ' \
             "#{command_name}#{argument_string}"))
  end
end
