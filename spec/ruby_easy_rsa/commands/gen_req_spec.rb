# frozen_string_literal: true

require 'spec_helper'

describe RubyEasyRSA::Commands::GenReq do
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

  it 'calls the easyrsa gen-req command with the filename base' do
    filename_base = 'some_important_thing'
    command = described_class.new(binary: 'easyrsa')

    command.execute(
      filename_base:
    )

    expect(executor.executions.first.command_line.string)
      .to(eq('easyrsa gen-req some_important_thing'))
  end

  it 'defaults to the configured binary when none provided' do
    filename_base = 'some_important_thing'
    command = described_class.new

    command.execute(
      filename_base:
    )

    expect(executor.executions.first.command_line.string)
      .to(eq('path/to/binary gen-req some_important_thing'))
  end

  it_behaves_like(
    'a command with global config',
    'gen-req',
    ['some_important_thing'],
    filename_base: 'some_important_thing'
  )
  it_behaves_like(
    'a command with algorithm config',
    'gen-req',
    ['some_important_thing'],
    filename_base: 'some_important_thing'
  )
  it_behaves_like(
    'a command with ssl config',
    'gen-req',
    ['some_important_thing'],
    filename_base: 'some_important_thing'
  )
  it_behaves_like(
    'a command with extra extensions config',
    'gen-req',
    ['some_important_thing'],
    filename_base: 'some_important_thing'
  )
  it_behaves_like(
    'a command with encrypt key config',
    'gen-req',
    ['some_important_thing'],
    filename_base: 'some_important_thing'
  )
end
