# frozen_string_literal: true

require 'spec_helper'

describe RubyEasyRSA::Commands::BuildClientFull do
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

  it 'calls the easyrsa build-client-full command with the filename base' do
    filename_base = 'some_important_thing'
    command = described_class.new(binary: 'easyrsa')

    command.execute(
      filename_base:
    )

    expect(executor.executions.first.command_line.string)
      .to(eq('easyrsa build-client-full some_important_thing'))
  end

  it 'defaults to the configured binary when none provided' do
    filename_base = 'some_important_thing'
    command = described_class.new

    command.execute(
      filename_base:
    )

    expect(executor.executions.first.command_line.string)
      .to(eq('path/to/binary build-client-full some_important_thing'))
  end

  it_behaves_like(
    'a command with global config',
    'build-client-full',
    ['some_important_thing'],
    filename_base: 'some_important_thing'
  )
  it_behaves_like(
    'a command with algorithm config',
    'build-client-full',
    ['some_important_thing'],
    filename_base: 'some_important_thing'
  )
  it_behaves_like(
    'a command with ssl config',
    'build-client-full',
    ['some_important_thing'],
    filename_base: 'some_important_thing'
  )
  it_behaves_like(
    'a command with sub-CA config',
    'build-client-full',
    ['some_important_thing'],
    filename_base: 'some_important_thing'
  )
  it_behaves_like(
    'a command with copy extensions config',
    'build-client-full',
    ['some_important_thing'],
    filename_base: 'some_important_thing'
  )
  it_behaves_like(
    'a command with extra extensions config',
    'build-client-full',
    ['some_important_thing'],
    filename_base: 'some_important_thing'
  )
  it_behaves_like(
    'a command with netscape extensions config',
    'build-client-full',
    ['some_important_thing'],
    filename_base: 'some_important_thing'
  )
  it_behaves_like(
    'a command with encrypt key config',
    'build-client-full',
    ['some_important_thing'],
    filename_base: 'some_important_thing'
  )
  it_behaves_like(
    'a command with inline credentials file config',
    'build-client-full',
    ['some_important_thing'],
    filename_base: 'some_important_thing'
  )

  it 'uses the provided sub-CA length' do
    filename_base = 'some_important_thing'
    sub_ca_length = 10
    command = described_class.new

    command.execute(
      filename_base:,
      sub_ca_length:
    )

    expect(executor.executions.first.command_line.string)
      .to(eq('path/to/binary --subca-len=10 ' \
             'build-client-full some_important_thing'))
  end
end
