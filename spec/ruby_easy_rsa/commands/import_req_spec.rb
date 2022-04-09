# frozen_string_literal: true

require 'spec_helper'

describe RubyEasyRSA::Commands::ImportReq do
  before do
    RubyEasyRSA.configure do |config|
      config.binary = 'path/to/binary'
    end
  end

  after do
    RubyEasyRSA.reset!
  end

  it 'calls the easyrsa import-req command' do
    request_file = 'path/to/some_important_thing.req'
    filename_base = 'some_important_thing'

    command = described_class.new(binary: 'easyrsa')

    allow(Open4).to(receive(:spawn))

    command.execute(
      request_file: request_file,
      filename_base: filename_base
    )

    expect(Open4)
      .to(have_received(:spawn)
            .with('easyrsa import-req ' \
                  'path/to/some_important_thing.req some_important_thing',
                  any_args))
  end

  it 'defaults to the configured binary when none provided' do
    request_file = 'path/to/some_important_thing.req'
    filename_base = 'some_important_thing'
    command = described_class.new

    allow(Open4).to(receive(:spawn))

    command.execute(
      request_file: request_file,
      filename_base: filename_base
    )

    expect(Open4)
      .to(have_received(:spawn)
            .with('path/to/binary import-req ' \
                  'path/to/some_important_thing.req some_important_thing',
                  any_args))
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
