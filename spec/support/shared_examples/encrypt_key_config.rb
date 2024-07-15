# frozen_string_literal: true

shared_examples(
  'a command with encrypt key config'
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

  it 'passes the nopass argument when encrypt_key is false' do
    encrypt_key = false

    command = described_class.new

    command.execute(
      options.merge(encrypt_key:)
    )

    expect(executor.executions.first.command_line.string)
      .to(eq("path/to/binary #{command_name}#{argument_string} nopass"))
  end

  it 'does not pass the nopass argument when encrypt_key is true' do
    encrypt_key = true

    command = described_class.new

    command.execute(
      options.merge(encrypt_key:)
    )

    expect(executor.executions.first.command_line.string)
      .to(eq("path/to/binary #{command_name}#{argument_string}"))
  end
end
