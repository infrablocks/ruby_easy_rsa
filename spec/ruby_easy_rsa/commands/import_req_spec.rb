# frozen_string_literal: true

require 'spec_helper'

describe RubyEasyRSA::Commands::ImportReq do
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

  it 'calls the easyrsa import-req command' do
    request_file = 'path/to/some_important_thing.req'
    filename_base = 'some_important_thing'

    command = described_class.new(binary: 'easyrsa')

    command.execute(
      request_file:,
      filename_base:
    )

    expect(executor.executions.first.command_line.string)
      .to(eq('easyrsa import-req ' \
             'path/to/some_important_thing.req some_important_thing'))
  end

  it 'defaults to the configured binary when none provided' do
    request_file = 'path/to/some_important_thing.req'
    filename_base = 'some_important_thing'
    command = described_class.new

    command.execute(
      request_file:,
      filename_base:
    )

    expect(executor.executions.first.command_line.string)
      .to(eq('path/to/binary import-req ' \
             'path/to/some_important_thing.req some_important_thing'))
  end

  it_behaves_like(
    'a command with global config',
    'import-req',
    %w[path/to/some_important_thing.req some_important_thing],
    filename_base: 'some_important_thing',
    request_file: 'path/to/some_important_thing.req'
  )
  it_behaves_like(
    'a command with ssl config',
    'import-req',
    %w[path/to/some_important_thing.req some_important_thing],
    filename_base: 'some_important_thing',
    request_file: 'path/to/some_important_thing.req'
  )
end
