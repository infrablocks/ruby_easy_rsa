# frozen_string_literal: true

shared_examples(
  'a command with inline credentials file config'
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

  it 'passes the inline argument when inline_credentials_file is true' do
    inline_credentials_file = true

    command = described_class.new

    command.execute(
      options.merge(inline_credentials_file:)
    )

    expect(executor.executions.first.command_line.string)
      .to(eq("path/to/binary #{command_name}#{argument_string} inline"))
  end

  it 'does not pass the inline argument when inline_credentials_file ' \
     'is false' do
    inline_credentials_file = false

    command = described_class.new

    command.execute(
      options.merge(inline_credentials_file:)
    )

    expect(executor.executions.first.command_line.string)
      .to(eq("path/to/binary #{command_name}#{argument_string}"))
  end
end
