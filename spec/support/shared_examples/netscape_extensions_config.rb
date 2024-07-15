# frozen_string_literal: true

shared_examples(
  'a command with netscape extensions config'
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

  it 'includes netscape extension support when requested' do
    netscape_extensions_support = true

    command = described_class.new

    command.execute(
      options.merge(
        netscape_extensions_support:
      )
    )

    expect(executor.executions.first.command_line.string)
      .to(eq('path/to/binary --ns-cert=yes ' \
             "#{command_name}#{argument_string}"))
  end

  it 'does not include netscape extension support when requested not to' do
    netscape_extensions_support = false
    command = described_class.new

    command.execute(
      options.merge(
        netscape_extensions_support:
      )
    )

    expect(executor.executions.first.command_line.string)
      .to(eq('path/to/binary --ns-cert=no ' \
             "#{command_name}#{argument_string}"))
  end

  it 'includes the provided netscape extension comment' do
    netscape_extensions_comment = 'Some comment'
    command = described_class.new

    command.execute(
      options.merge(
        netscape_extensions_comment:
      )
    )

    expect(executor.executions.first.command_line.string)
      .to(eq('path/to/binary --ns-comment="Some comment" ' \
             "#{command_name}#{argument_string}"))
  end
end
