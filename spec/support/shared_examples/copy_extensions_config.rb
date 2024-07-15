# frozen_string_literal: true

shared_examples(
  'a command with copy extensions config'
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

  it 'includes the copy-ext switch when copy extensions is true' do
    command = described_class.new

    command.execute(
      options.merge(copy_extensions: true)
    )

    expect(executor.executions.first.command_line.string)
      .to(eq("path/to/binary --copy-ext #{command_name}#{argument_string}"))
  end

  it 'does not include the copy-ext switch when copy extensions is false' do
    command = described_class.new

    command.execute(
      options.merge(copy_extensions: false)
    )

    expect(executor.executions.first.command_line.string)
      .to(eq("path/to/binary #{command_name}#{argument_string}"))
  end
end
