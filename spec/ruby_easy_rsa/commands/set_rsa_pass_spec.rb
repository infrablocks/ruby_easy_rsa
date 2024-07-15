# frozen_string_literal: true

require 'spec_helper'

describe RubyEasyRSA::Commands::SetRSAPass do
  before do
    RubyEasyRSA.configure do |config|
      config.binary = 'path/to/binary'
    end
  end

  after do
    RubyEasyRSA.reset!
  end

  it 'calls the easyrsa set-rsa-pass command with the filename base' do
    filename_base = 'some_important_thing'
    command = described_class.new(binary: 'easyrsa')

    allow(Open4).to(receive(:spawn))

    command.execute(
      filename_base:
    )

    expect(Open4)
      .to(have_received(:spawn)
            .with('easyrsa set-rsa-pass some_important_thing',
                  any_args))
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
            .with('path/to/binary set-rsa-pass some_important_thing',
                  any_args))
  end

  it_behaves_like(
    'a command with global config',
    'set-rsa-pass',
    ['some_important_thing'],
    filename_base: 'some_important_thing'
  )
  it_behaves_like(
    'a command with ssl config',
    'set-rsa-pass',
    ['some_important_thing'],
    filename_base: 'some_important_thing'
  )
  it_behaves_like(
    'a command with encrypt key config',
    'set-rsa-pass',
    ['some_important_thing'],
    filename_base: 'some_important_thing'
  )

  it 'includes the file argument when file is true' do
    filename_base = 'some_important_thing'
    command = described_class.new

    allow(Open4).to(receive(:spawn))

    command.execute(
      filename_base:,
      file: true
    )

    expect(Open4)
      .to(have_received(:spawn)
            .with('path/to/binary set-rsa-pass some_important_thing file',
                  any_args))
  end

  it 'does not include the file argument when file is false' do
    filename_base = 'some_important_thing'
    command = described_class.new

    allow(Open4).to(receive(:spawn))

    command.execute(
      filename_base:,
      file: false
    )

    expect(Open4)
      .to(have_received(:spawn)
            .with('path/to/binary set-rsa-pass some_important_thing',
                  any_args))
  end
end
