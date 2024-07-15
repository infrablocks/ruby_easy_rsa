# frozen_string_literal: true

require 'spec_helper'

describe RubyEasyRSA::Commands::ShowReq do
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

  it 'calls the easyrsa show-req command' do
    command = described_class.new(binary: 'easyrsa')

    command.execute

    expect(executor.executions.first.command_line.string)
      .to(eq('easyrsa show-req'))
  end

  it 'defaults to the configured binary when none provided' do
    command = described_class.new

    command.execute

    expect(executor.executions.first.command_line.string)
      .to(eq('path/to/binary show-req'))
  end

  it_behaves_like(
    'a command with global config',
    'show-req',
    ['some_important_thing'],
    filename_base: 'some_important_thing'
  )
  it_behaves_like(
    'a command with ssl config',
    'show-req',
    ['some_important_thing'],
    filename_base: 'some_important_thing'
  )

  it 'passes the full argument when full is true' do
    filename_base = 'some_important_thing'
    full = true

    command = described_class.new

    command.execute(
      full:,
      filename_base:
    )

    expect(executor.executions.first.command_line.string)
      .to(eq('path/to/binary show-req some_important_thing full'))
  end

  it 'does not pass the full argument when full is false' do
    filename_base = 'some_important_thing'
    full = false

    command = described_class.new

    command.execute(
      full:,
      filename_base:
    )

    expect(executor.executions.first.command_line.string)
      .to(eq('path/to/binary show-req some_important_thing'))
  end
end
