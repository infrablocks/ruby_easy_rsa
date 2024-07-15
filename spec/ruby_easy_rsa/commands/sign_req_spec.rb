# frozen_string_literal: true

require 'spec_helper'

describe RubyEasyRSA::Commands::SignReq do
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

  it 'calls the easyrsa sign-req command with the filename base' do
    type = 'ca'
    filename_base = 'some_important_thing'
    command = described_class.new(binary: 'easyrsa')

    command.execute(
      filename_base:,
      type:
    )

    expect(executor.executions.first.command_line.string)
      .to(eq('easyrsa sign-req ca some_important_thing'))
  end

  it 'defaults to the configured binary when none provided' do
    type = 'server'
    filename_base = 'some_important_thing'
    command = described_class.new

    command.execute(
      filename_base:,
      type:
    )

    expect(executor.executions.first.command_line.string)
      .to(eq('path/to/binary sign-req server some_important_thing'))
  end

  it_behaves_like(
    'a command with global config',
    'sign-req',
    %w[server some_important_thing],
    filename_base: 'some_important_thing',
    type: 'server'
  )
  it_behaves_like(
    'a command with algorithm config',
    'sign-req',
    %w[client some_important_thing],
    filename_base: 'some_important_thing',
    type: 'client'
  )
  it_behaves_like(
    'a command with ssl config',
    'sign-req',
    %w[ca some_important_thing],
    filename_base: 'some_important_thing',
    type: 'ca'
  )
  it_behaves_like(
    'a command with sub-CA config',
    'sign-req',
    %w[ca some_important_thing],
    filename_base: 'some_important_thing',
    type: 'ca'
  )
  it_behaves_like(
    'a command with copy extensions config',
    'sign-req',
    %w[ca some_important_thing],
    filename_base: 'some_important_thing',
    type: 'ca'
  )
  it_behaves_like(
    'a command with extra extensions config',
    'sign-req',
    %w[ca some_important_thing],
    filename_base: 'some_important_thing',
    type: 'ca'
  )
  it_behaves_like(
    'a command with netscape extensions config',
    'sign-req',
    %w[ca some_important_thing],
    filename_base: 'some_important_thing',
    type: 'ca'
  )
end
