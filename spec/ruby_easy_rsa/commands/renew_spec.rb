# frozen_string_literal: true

require 'spec_helper'

describe RubyEasyRSA::Commands::Renew do
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

  it 'calls the easyrsa renew command' do
    command = described_class.new(binary: 'easyrsa')

    command.execute

    expect(executor.executions.first.command_line.string)
      .to(eq('easyrsa renew'))
  end

  it 'defaults to the configured binary when none provided' do
    command = described_class.new

    command.execute

    expect(executor.executions.first.command_line.string)
      .to(eq('path/to/binary renew'))
  end

  it_behaves_like(
    'a command with global config',
    'renew',
    ['some_important_thing'],
    filename_base: 'some_important_thing'
  )
  it_behaves_like(
    'a command with ssl config',
    'renew',
    ['some_important_thing'],
    filename_base: 'some_important_thing'
  )
  it_behaves_like(
    'a command with encrypt key config',
    'renew',
    ['some_important_thing'],
    filename_base: 'some_important_thing'
  )
end
