# frozen_string_literal: true

require 'spec_helper'

describe RubyEasyRSA::Commands::ExportP7 do
  let(:executor) { Lino::Executors::Mock.new }

  before do
    RubyEasyRSA.configure do |config|
      config.binary = 'path/to/binary'
    end
    Lino.configure do |config|
      config.executor = executor
    end
  end

  after do
    Lino.reset!
    RubyEasyRSA.reset!
  end

  it 'calls the easyrsa export-p7 command with the filename base' do
    filename_base = 'some_important_thing'
    command = described_class.new(binary: 'easyrsa')

    command.execute(
      filename_base:
    )

    expect(executor.executions.first.command_line.string)
      .to(eq('easyrsa export-p7 some_important_thing'))
  end

  it 'defaults to the configured binary when none provided' do
    filename_base = 'some_important_thing'
    command = described_class.new

    command.execute(
      filename_base:
    )

    expect(executor.executions.first.command_line.string)
      .to(eq('path/to/binary export-p7 some_important_thing'))
  end

  it_behaves_like(
    'a command with global config',
    'export-p7',
    ['some_important_thing'],
    filename_base: 'some_important_thing'
  )
  it_behaves_like(
    'a command with ssl config',
    'export-p7',
    ['some_important_thing'],
    filename_base: 'some_important_thing'
  )

  it 'does not include the noca argument when include_ca is true' do
    filename_base = 'some_important_thing'
    command = described_class.new

    command.execute(
      filename_base:,
      include_ca: true
    )

    expect(executor.executions.first.command_line.string)
      .to(eq('path/to/binary export-p7 some_important_thing'))
  end

  it 'includes the noca argument when include_ca is false' do
    filename_base = 'some_important_thing'
    command = described_class.new

    command.execute(
      filename_base:,
      include_ca: false
    )

    expect(executor.executions.first.command_line.string)
      .to(eq('path/to/binary export-p7 some_important_thing noca'))
  end
end
