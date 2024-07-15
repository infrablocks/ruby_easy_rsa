# frozen_string_literal: true

shared_examples(
  'a command with extra extensions config'
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

  it 'includes the provided extra extensions' do
    extra_extensions = 'someExtraExtension = value'

    command = described_class.new

    command.execute(
      options.merge(extra_extensions:)
    )

    expect(executor.executions.first.command_line.string)
      .to(eq('EASYRSA_EXTRA_EXT="someExtraExtension = value" ' \
             "path/to/binary #{command_name}#{argument_string}"))
  end

  it 'includes the provided subject alternative name' do
    subject_alternative_name = 'some.name.example.com'

    command = described_class.new

    command.execute(
      options.merge(
        subject_alternative_name:
      )
    )

    expect(executor.executions.first.command_line.string)
      .to(eq('path/to/binary ' \
             '--subject-alt-name="some.name.example.com" ' \
             "#{command_name}#{argument_string}"))
  end
end
