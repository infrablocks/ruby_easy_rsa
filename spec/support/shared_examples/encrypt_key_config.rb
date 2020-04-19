shared_examples(
    "a command with encrypt key config"
) do |command_name, arguments = [], options = {}|
  let(:argument_string) do
    arguments.empty? ? "" : " #{arguments.join(" ")}"
  end

  it 'passes the nopass argument when encrypt_key is false' do
    encrypt_key = false

    command = subject.class.new

    expect(Open4).to(
        receive(:spawn)
            .with("path/to/binary #{command_name}#{argument_string} nopass",
                any_args))

    command.execute(
        options.merge(encrypt_key: encrypt_key))
  end

  it 'does not pass the nopass argument when encrypt_key is true' do
    encrypt_key = true

    command = subject.class.new

    expect(Open4).to(
        receive(:spawn)
            .with("path/to/binary #{command_name}#{argument_string}",
                any_args))

    command.execute(
        options.merge(encrypt_key: encrypt_key))
  end
end
