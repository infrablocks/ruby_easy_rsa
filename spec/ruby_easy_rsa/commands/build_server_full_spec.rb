# frozen_string_literal: true

require 'spec_helper'

describe RubyEasyRSA::Commands::BuildServerFull do
  before do
    RubyEasyRSA.configure do |config|
      config.binary = 'path/to/binary'
    end
  end

  after do
    RubyEasyRSA.reset!
  end

  it 'calls the easyrsa build-server-full command with the filename base' do
    filename_base = 'some_important_thing'
    command = described_class.new(binary: 'easyrsa')

    allow(Open4).to(receive(:spawn))

    command.execute(
      filename_base: filename_base
    )

    expect(Open4)
      .to(have_received(:spawn)
            .with('easyrsa build-server-full some_important_thing',
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
            .with('path/to/binary build-server-full some_important_thing',
                  any_args))
  end

  it_behaves_like(
    'a command with global config',
    'build-server-full',
    ['some_important_thing'],
    filename_base: 'some_important_thing'
  )
  it_behaves_like(
    'a command with algorithm config',
    'build-server-full',
    ['some_important_thing'],
    filename_base: 'some_important_thing'
  )
  it_behaves_like(
    'a command with ssl config',
    'build-server-full',
    ['some_important_thing'],
    filename_base: 'some_important_thing'
  )
  it_behaves_like(
    'a command with sub-CA config',
    'build-server-full',
    ['some_important_thing'],
    filename_base: 'some_important_thing'
  )
  it_behaves_like(
    'a command with copy extensions config',
    'build-server-full',
    ['some_important_thing'],
    filename_base: 'some_important_thing'
  )
  it_behaves_like(
    'a command with extra extensions config',
    'build-server-full',
    ['some_important_thing'],
    filename_base: 'some_important_thing'
  )
  it_behaves_like(
    'a command with netscape extensions config',
    'build-server-full',
    ['some_important_thing'],
    filename_base: 'some_important_thing'
  )
  it_behaves_like(
    'a command with encrypt key config',
    'build-server-full',
    ['some_important_thing'],
    filename_base: 'some_important_thing'
  )
  it_behaves_like(
    'a command with inline credentials file config',
    'build-server-full',
    ['some_important_thing'],
    filename_base: 'some_important_thing'
  )

  it 'uses the provided sub-CA length' do
    filename_base = 'some_important_thing'
    sub_ca_length = 10
    command = described_class.new

    allow(Open4).to(receive(:spawn))

    command.execute(
      filename_base: filename_base,
      sub_ca_length: sub_ca_length
    )

    expect(Open4)
      .to(have_received(:spawn)
            .with('path/to/binary --subca-len=10 ' \
                  'build-server-full some_important_thing',
                  any_args))
  end
end
