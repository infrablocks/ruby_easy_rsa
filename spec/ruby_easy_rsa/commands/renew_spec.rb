# frozen_string_literal: true

require 'spec_helper'

describe RubyEasyRSA::Commands::Renew do
  before do
    RubyEasyRSA.configure do |config|
      config.binary = 'path/to/binary'
    end
  end

  after do
    RubyEasyRSA.reset!
  end

  it 'calls the easyrsa renew command' do
    command = described_class.new(binary: 'easyrsa')

    allow(Open4).to(receive(:spawn))

    command.execute

    expect(Open4)
      .to(have_received(:spawn)
            .with('easyrsa renew', any_args))
  end

  it 'defaults to the configured binary when none provided' do
    command = described_class.new

    allow(Open4).to(receive(:spawn))

    command.execute

    expect(Open4)
      .to(have_received(:spawn)
            .with('path/to/binary renew', any_args))
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
