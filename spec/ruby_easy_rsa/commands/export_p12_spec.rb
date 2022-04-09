# frozen_string_literal: true

require 'spec_helper'

describe RubyEasyRSA::Commands::ExportP12 do
  before do
    RubyEasyRSA.configure do |config|
      config.binary = 'path/to/binary'
    end
  end

  after do
    RubyEasyRSA.reset!
  end

  it 'calls the easyrsa export-p12 command with the filename base' do
    filename_base = 'some_important_thing'
    command = described_class.new(binary: 'easyrsa')

    allow(Open4).to(receive(:spawn))

    command.execute(
      filename_base: filename_base
    )

    expect(Open4)
      .to(have_received(:spawn)
            .with('easyrsa export-p12 some_important_thing',
                  any_args))
  end

  it 'defaults to the configured binary when none provided' do
    filename_base = 'some_important_thing'
    command = described_class.new

    allow(Open4).to(receive(:spawn))

    command.execute(
      filename_base: filename_base
    )

    expect(Open4)
      .to(have_received(:spawn)
            .with('path/to/binary export-p12 some_important_thing',
                  any_args))
  end

  it_behaves_like(
    'a command with global config',
    'export-p12',
    ['some_important_thing'],
    filename_base: 'some_important_thing'
  )
  it_behaves_like(
    'a command with ssl config',
    'export-p12',
    ['some_important_thing'],
    filename_base: 'some_important_thing'
  )

  it 'does not include the noca argument when include_ca is true' do
    filename_base = 'some_important_thing'
    command = described_class.new

    allow(Open4).to(receive(:spawn))

    command.execute(
      filename_base: filename_base,
      include_ca: true
    )

    expect(Open4)
      .to(have_received(:spawn)
            .with('path/to/binary export-p12 some_important_thing',
                  any_args))
  end

  it 'includes the noca argument when include_ca is false' do
    filename_base = 'some_important_thing'
    command = described_class.new

    allow(Open4).to(receive(:spawn))

    command.execute(
      filename_base: filename_base,
      include_ca: false
    )

    expect(Open4)
      .to(have_received(:spawn)
            .with('path/to/binary export-p12 some_important_thing noca',
                  any_args))
  end

  it 'does not include the nokey argument when include_key is true' do
    filename_base = 'some_important_thing'
    command = described_class.new

    allow(Open4).to(receive(:spawn))

    command.execute(
      filename_base: filename_base,
      include_key: true
    )

    expect(Open4)
      .to(have_received(:spawn)
            .with('path/to/binary export-p12 some_important_thing',
                  any_args))
  end

  it 'includes the nokey argument when include_key is false' do
    filename_base = 'some_important_thing'
    command = described_class.new

    allow(Open4).to(receive(:spawn))

    command.execute(
      filename_base: filename_base,
      include_key: false
    )

    expect(Open4)
      .to(have_received(:spawn)
            .with('path/to/binary export-p12 some_important_thing nokey',
                  any_args))
  end
end
