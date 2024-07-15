# frozen_string_literal: true

require 'spec_helper'

describe RubyEasyRSA::Commands::GenReq do
  before do
    RubyEasyRSA.configure do |config|
      config.binary = 'path/to/binary'
    end
  end

  after do
    RubyEasyRSA.reset!
  end

  it 'calls the easyrsa gen-req command with the filename base' do
    filename_base = 'some_important_thing'
    command = described_class.new(binary: 'easyrsa')

    allow(Open4).to(receive(:spawn))

    command.execute(
      filename_base:
    )

    expect(Open4)
      .to(have_received(:spawn)
            .with('easyrsa gen-req some_important_thing', any_args))
  end

  it 'defaults to the configured binary when none provided' do
    filename_base = 'some_important_thing'
    command = described_class.new

    allow(Open4).to(receive(:spawn))

    command.execute(
      filename_base:
    )

    expect(Open4)
      .to(have_received(:spawn)
            .with('path/to/binary gen-req some_important_thing', any_args))
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
