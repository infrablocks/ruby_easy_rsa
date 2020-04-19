require 'spec_helper'

require_relative '../support/shared_examples/global_config'
require_relative '../support/shared_examples/ssl_config'

describe RubyEasyRSA::Commands::ImportReq do
  before(:each) do
    RubyEasyRSA.configure do |config|
      config.binary = 'path/to/binary'
    end
  end

  after(:each) do
    RubyEasyRSA.reset!
  end

  it 'calls the easyrsa import-req command' do
    request_file = "path/to/some_important_thing.req"
    filename_base = "some_important_thing"

    command = subject.class.new(binary: 'easyrsa')

    expect(Open4).to(
        receive(:spawn)
            .with('easyrsa import-req ' +
                'path/to/some_important_thing.req some_important_thing',
                any_args))

    command.execute(
        request_file: request_file,
        filename_base: filename_base)
  end

  it 'defaults to the configured binary when none provided' do
    request_file = "path/to/some_important_thing.req"
    filename_base = "some_important_thing"
    command = subject.class.new

    expect(Open4).to(
        receive(:spawn)
            .with('path/to/binary import-req ' +
                'path/to/some_important_thing.req some_important_thing',
                any_args))

    command.execute(
        request_file: request_file,
        filename_base: filename_base)
  end

  it_behaves_like("a command with global config",
      "import-req",
      ["path/to/some_important_thing.req", "some_important_thing"],
      filename_base: "some_important_thing",
      request_file: "path/to/some_important_thing.req")
  it_behaves_like("a command with ssl config",
      "import-req",
      ["path/to/some_important_thing.req", "some_important_thing"],
      filename_base: "some_important_thing",
      request_file: "path/to/some_important_thing.req")
end
