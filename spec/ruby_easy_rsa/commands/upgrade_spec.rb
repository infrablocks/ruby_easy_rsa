# frozen_string_literal: true

require 'spec_helper'

describe RubyEasyRSA::Commands::Upgrade do
  before do
    RubyEasyRSA.configure do |config|
      config.binary = 'path/to/binary'
    end
  end

  after do
    RubyEasyRSA.reset!
  end

  it 'calls the easyrsa upgrade command' do
    command = described_class.new(binary: 'easyrsa')

    allow(Open4).to(receive(:spawn))

    command.execute

    expect(Open4)
      .to(have_received(:spawn)
            .with('easyrsa upgrade', any_args))
  end

  it 'defaults to the configured binary when none provided' do
    command = described_class.new

    allow(Open4).to(receive(:spawn))

    command.execute

    expect(Open4)
      .to(have_received(:spawn)
            .with('path/to/binary upgrade', any_args))
  end

  it_behaves_like(
    'a command with global config',
    'upgrade',
    ['pki'],
    type: 'pki'
  )
  it_behaves_like(
    'a command with ssl config',
    'upgrade',
    ['ca'],
    type: 'ca'
  )
end
