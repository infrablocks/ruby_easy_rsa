# frozen_string_literal: true

require 'spec_helper'

describe RubyEasyRSA::Commands::BuildCA do
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

  it 'calls the easyrsa build-ca command' do
    command = described_class.new(binary: 'easyrsa')

    command.execute

    expect(executor.executions.first.command_line.string)
      .to(eq('easyrsa build-ca'))
  end

  it 'defaults to the configured binary when none provided' do
    command = described_class.new

    command.execute

    expect(executor.executions.first.command_line.string)
      .to(eq('path/to/binary build-ca'))
  end

  it_behaves_like 'a command with global config', 'build-ca'
  it_behaves_like 'a command with algorithm config', 'build-ca'
  it_behaves_like 'a command with ssl config', 'build-ca'
  it_behaves_like 'a command with encrypt key config', 'build-ca'

  it 'passes the subca argument when sub_ca is true' do
    sub_ca = true

    command = described_class.new

    command.execute(
      sub_ca:
    )

    expect(executor.executions.first.command_line.string)
      .to(eq('path/to/binary build-ca subca'))
  end

  it 'does not pass the subca argument when sub_ca is false' do
    sub_ca = false

    command = described_class.new

    command.execute(
      sub_ca:
    )

    expect(executor.executions.first.command_line.string)
      .to(eq('path/to/binary build-ca'))
  end
end
