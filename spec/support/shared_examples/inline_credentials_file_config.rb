shared_examples(
    "a command with inline credentials file config"
) do |command_name, arguments = [], options = {}|
  let(:argument_string) do
    arguments.empty? ? "" : " #{arguments.join(" ")}"
  end

  it 'passes the inline argument when inline_credentials_file is true' do
    inline_credentials_file = true

    command = subject.class.new

    expect(Open4).to(
        receive(:spawn)
            .with("path/to/binary #{command_name}#{argument_string} inline",
                any_args))

    command.execute(
        options.merge(inline_credentials_file: inline_credentials_file))
  end

  it 'does not pass the inline argument when inline_credentials_file ' +
      'is false' do
    inline_credentials_file = false

    command = subject.class.new

    expect(Open4).to(
        receive(:spawn)
            .with("path/to/binary #{command_name}#{argument_string}",
                any_args))

    command.execute(
        options.merge(inline_credentials_file: inline_credentials_file))
  end
end
