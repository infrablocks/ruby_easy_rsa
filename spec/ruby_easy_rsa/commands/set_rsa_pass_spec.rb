# frozen_string_literal: true

require 'spec_helper'

describe RubyEasyRSA::Commands::SetRSAPass do
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

  it 'calls the easyrsa set-rsa-pass command with the filename base' do
    filename_base = 'some_important_thing'
    command = described_class.new(binary: 'easyrsa')

    command.execute(
      filename_base:
    )

    expect(executor.executions.first.command_line.string)
      .to(eq('easyrsa set-rsa-pass some_important_thing'))
  end

  it 'defaults to the configured binary when none provided' do
    filename_base = 'some_important_thing'
    command = described_class.new

    command.execute(
      filename_base:
    )

    expect(executor.executions.first.command_line.string)
      .to(eq('path/to/binary set-rsa-pass some_important_thing'))
  end

  it_behaves_like(
    'a command with global config',
    'set-rsa-pass',
    ['some_important_thing'],
    filename_base: 'some_important_thing'
  )
  it_behaves_like(
    'a command with ssl config',
    'set-rsa-pass',
    ['some_important_thing'],
    filename_base: 'some_important_thing'
  )
  it_behaves_like(
    'a command with encrypt key config',
    'set-rsa-pass',
    ['some_important_thing'],
    filename_base: 'some_important_thing'
  )

  it 'includes the file argument when file is true' do
    filename_base = 'some_important_thing'
    command = described_class.new

    command.execute(
      filename_base:,
      file: true
    )

    expect(executor.executions.first.command_line.string)
      .to(eq('path/to/binary set-rsa-pass some_important_thing file'))
  end

  it 'does not include the file argument when file is false' do
    filename_base = 'some_important_thing'
    command = described_class.new

    command.execute(
      filename_base:,
      file: false
    )

    expect(executor.executions.first.command_line.string)
      .to(eq('path/to/binary set-rsa-pass some_important_thing'))
  end
end
