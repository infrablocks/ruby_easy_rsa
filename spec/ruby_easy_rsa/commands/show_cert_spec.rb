# frozen_string_literal: true

require 'spec_helper'

describe RubyEasyRSA::Commands::ShowCert do
  before do
    RubyEasyRSA.configure do |config|
      config.binary = 'path/to/binary'
    end
  end

  after do
    RubyEasyRSA.reset!
  end

  it 'calls the easyrsa show-cert command' do
    command = described_class.new(binary: 'easyrsa')

    allow(Open4).to(receive(:spawn))

    command.execute

    expect(Open4)
      .to(have_received(:spawn)
            .with('easyrsa show-cert', any_args))
  end

  it 'defaults to the configured binary when none provided' do
    command = described_class.new

    allow(Open4).to(receive(:spawn))

    command.execute

    expect(Open4)
      .to(have_received(:spawn)
            .with('path/to/binary show-cert', any_args))
  end

  it_behaves_like(
    'a command with global config',
    'show-cert',
    ['some_important_thing'],
    filename_base: 'some_important_thing'
  )
  it_behaves_like(
    'a command with ssl config',
    'show-cert',
    ['some_important_thing'],
    filename_base: 'some_important_thing'
  )

  it 'passes the full argument when full is true' do
    filename_base = 'some_important_thing'
    full = true

    command = described_class.new

    allow(Open4).to(receive(:spawn))

    command.execute(
      full:,
      filename_base:
    )

    expect(Open4)
      .to(have_received(:spawn)
            .with('path/to/binary show-cert some_important_thing full',
                  any_args))
  end

  it 'does not pass the full argument when full is false' do
    filename_base = 'some_important_thing'
    full = false

    command = described_class.new

    allow(Open4).to(receive(:spawn))

    command.execute(
      full:,
      filename_base:
    )

    expect(Open4)
      .to(have_received(:spawn)
            .with('path/to/binary show-cert some_important_thing',
                  any_args))
  end
end
