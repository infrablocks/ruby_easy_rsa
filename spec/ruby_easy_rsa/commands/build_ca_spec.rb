# frozen_string_literal: true

require 'spec_helper'

describe RubyEasyRSA::Commands::BuildCA do
  before do
    RubyEasyRSA.configure do |config|
      config.binary = 'path/to/binary'
    end
  end

  after do
    RubyEasyRSA.reset!
  end

  it 'calls the easyrsa build-ca command' do
    command = described_class.new(binary: 'easyrsa')

    allow(Open4).to(receive(:spawn))

    command.execute

    expect(Open4)
      .to(have_received(:spawn)
            .with('easyrsa build-ca', any_args))
  end

  it 'defaults to the configured binary when none provided' do
    command = described_class.new

    allow(Open4).to(receive(:spawn))

    command.execute

    expect(Open4)
      .to(have_received(:spawn)
            .with('path/to/binary build-ca', any_args))
  end

  it_behaves_like 'a command with global config', 'build-ca'
  it_behaves_like 'a command with algorithm config', 'build-ca'
  it_behaves_like 'a command with ssl config', 'build-ca'
  it_behaves_like 'a command with encrypt key config', 'build-ca'

  it 'passes the subca argument when sub_ca is true' do
    sub_ca = true

    command = described_class.new

    allow(Open4).to(receive(:spawn))

    command.execute(
      sub_ca:
    )

    expect(Open4)
      .to(have_received(:spawn)
            .with('path/to/binary build-ca subca', any_args))
  end

  it 'does not pass the subca argument when sub_ca is false' do
    sub_ca = false

    command = described_class.new

    allow(Open4).to(receive(:spawn))

    command.execute(
      sub_ca:
    )

    expect(Open4)
      .to(have_received(:spawn)
            .with('path/to/binary build-ca', any_args))
  end
end
