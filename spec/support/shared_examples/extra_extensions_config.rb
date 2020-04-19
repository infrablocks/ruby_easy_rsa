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
end
