shared_examples(
    "a command with extra extensions config"
) do |command_name, arguments = [], options = {}|
  let(:argument_string) do
    arguments.empty? ? "" : " #{arguments.join(" ")}"
  end

  it 'includes the provided extra extensions' do
    extra_extensions = 'someExtraExtension = value'

    command = subject.class.new

    expect(Open4).to(
        receive(:spawn)
            .with('EASYRSA_EXTRA_EXT="someExtraExtension = value" ' +
                "path/to/binary #{command_name}#{argument_string}",
                any_args))

    command.execute(
        options.merge(extra_extensions: extra_extensions))
  end

  it 'includes the provided subject alternative name' do
    subject_alternative_name = 'some.name.example.com'

    command = subject.class.new

    expect(Open4).to(
        receive(:spawn)
            .with("path/to/binary " +
                "--subject-alt-name=\"some.name.example.com\" " +
                "#{command_name}#{argument_string}",
                any_args))

    command.execute(
        options.merge(
            subject_alternative_name: subject_alternative_name))
  end
end
