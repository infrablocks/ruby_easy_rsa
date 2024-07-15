# frozen_string_literal: true

shared_examples(
  'a command with sub-CA config'
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

  it 'uses the provided sub-CA length' do
    sub_ca_length = 10

    command = described_class.new

    command.execute(
      options.merge(sub_ca_length:)
    )

    expect(executor.executions.first.command_line.string)
      .to(eq('path/to/binary --subca-len=10 ' \
             "#{command_name}#{argument_string}"))
  end
end
