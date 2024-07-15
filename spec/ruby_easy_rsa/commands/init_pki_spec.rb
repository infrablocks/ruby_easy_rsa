# frozen_string_literal: true

require 'spec_helper'

describe RubyEasyRSA::Commands::InitPKI do
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

  it 'calls the easyrsa init-pki command' do
    command = described_class.new(binary: 'easyrsa')

    command.execute

    expect(executor.executions.first.command_line.string)
      .to(eq('easyrsa init-pki'))
  end

  it 'defaults to the configured binary when none provided' do
    command = described_class.new

    command.execute

    expect(executor.executions.first.command_line.string)
      .to(eq('path/to/binary init-pki'))
  end

  it_behaves_like('a command with global config', 'init-pki')
  it_behaves_like('a command with ssl config', 'init-pki')
end
