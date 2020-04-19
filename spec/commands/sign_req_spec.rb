require 'spec_helper'

require_relative '../support/shared_examples/global_config'
require_relative '../support/shared_examples/algorithm_config'
require_relative '../support/shared_examples/ssl_config'
require_relative '../support/shared_examples/sub_ca_config'
require_relative '../support/shared_examples/copy_extensions_config'
require_relative '../support/shared_examples/extra_extensions_config'
require_relative '../support/shared_examples/netscape_extensions_config'

describe RubyEasyRSA::Commands::SignReq do
  before(:each) do
    RubyEasyRSA.configure do |config|
      config.binary = 'path/to/binary'
    end
  end

  after(:each) do
    RubyEasyRSA.reset!
  end

  it 'calls the easyrsa sign-req command with the filename base' do
    type = "ca"
    filename_base = 'some_important_thing'
    command = subject.class.new(binary: 'easyrsa')

    expect(Open4).to(
        receive(:spawn)
            .with('easyrsa sign-req ca some_important_thing',
                any_args))

    command.execute(
        filename_base: filename_base,
        type: type)
  end

  it 'defaults to the configured binary when none provided' do
    type = "server"
    filename_base = 'some_important_thing'
    command = subject.class.new

    expect(Open4).to(
        receive(:spawn)
            .with('path/to/binary sign-req server some_important_thing',
                any_args))

    command.execute(
        filename_base: filename_base,
        type: type)
  end

  it_behaves_like("a command with global config",
      "sign-req",
      ["server", "some_important_thing"],
      filename_base: "some_important_thing",
      type: "server")
  it_behaves_like("a command with algorithm config",
      "sign-req",
      ["client", "some_important_thing"],
      filename_base: "some_important_thing",
      type: "client")
  it_behaves_like("a command with ssl config",
      "sign-req",
      ["ca", "some_important_thing"],
      filename_base: "some_important_thing",
      type: "ca")
  it_behaves_like("a command with sub-CA config",
      "sign-req",
      ["ca", "some_important_thing"],
      filename_base: "some_important_thing",
      type: "ca")
  it_behaves_like("a command with copy extensions config",
      "sign-req",
      ["ca", "some_important_thing"],
      filename_base: "some_important_thing",
      type: "ca")
  it_behaves_like("a command with extra extensions config",
      "sign-req",
      ["ca", "some_important_thing"],
      filename_base: "some_important_thing",
      type: "ca")
  it_behaves_like("a command with netscape extensions config",
      "sign-req",
      ["ca", "some_important_thing"],
      filename_base: "some_important_thing",
      type: "ca")
end
