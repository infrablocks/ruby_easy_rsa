# frozen_string_literal: true

shared_examples(
  'a command with algorithm config'
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

  it 'uses the provided algorithm when specified' do
    algorithm = 'ec'

    command = described_class.new

    command.execute(
      options.merge(algorithm:)
    )

    expect(executor.executions.first.command_line.string)
      .to(eq("path/to/binary --use-algo=ec #{command_name}#{argument_string}"))
  end

  it 'uses the provided curve when specified' do
    curve = 'sect571k1'

    command = described_class.new

    command.execute(
      options.merge(curve:)
    )

    expect(executor.executions.first.command_line.string)
      .to(eq(
            "path/to/binary --curve=sect571k1 #{command_name}#{argument_string}"
          ))
  end

  it 'uses the provided ec directory when specified' do
    ec_directory = './ec'

    command = described_class.new

    command.execute(
      options.merge(ec_directory:)
    )

    expect(executor.executions.first.command_line.string)
      .to(eq(
            'EASYRSA_EC_DIR="./ec" path/to/binary ' \
            "#{command_name}#{argument_string}"
          ))
  end
end
