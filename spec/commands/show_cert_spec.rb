require 'spec_helper'

require_relative '../support/shared_examples/global_config'
require_relative '../support/shared_examples/ssl_config'

describe RubyEasyRSA::Commands::ShowCert do
  before(:each) do
    RubyEasyRSA.configure do |config|
      config.binary = 'path/to/binary'
    end
  end

  after(:each) do
    RubyEasyRSA.reset!
  end

  it 'calls the easyrsa show-cert command' do
    command = subject.class.new(binary: 'easyrsa')

    expect(Open4).to(
        receive(:spawn)
            .with('easyrsa show-cert', any_args))

    command.execute
  end

  it 'defaults to the configured binary when none provided' do
    command = subject.class.new

    expect(Open4).to(
        receive(:spawn)
            .with('path/to/binary show-cert', any_args))

    command.execute
  end

  it_behaves_like("a command with global config",
      "show-cert",
      ["some_important_thing"],
      filename_base: "some_important_thing")
  it_behaves_like("a command with ssl config",
      "show-cert",
      ["some_important_thing"],
      filename_base: "some_important_thing")

  it 'passes the full argument when full is true' do
    filename_base = "some_important_thing"
    full = true

    command = subject.class.new

    expect(Open4).to(
        receive(:spawn)
            .with("path/to/binary show-cert some_important_thing full",
                any_args))

    command.execute(
        full: full,
        filename_base: filename_base)
  end

  it 'does not pass the full argument when full is false' do
    filename_base = "some_important_thing"
    full = false

    command = subject.class.new

    expect(Open4).to(
        receive(:spawn)
            .with("path/to/binary show-cert some_important_thing",
                any_args))

    command.execute(
        full: full,
        filename_base: filename_base)
  end
end
