shared_examples(
    "a command with netscape extensions config"
) do |command_name, arguments = [], options = {}|
  let(:argument_string) do
    arguments.empty? ? "" : " #{arguments.join(" ")}"
  end

  it 'includes netscape extension support when requested' do
    netscape_extensions_support = true

    command = subject.class.new

    expect(Open4).to(
        receive(:spawn)
            .with('path/to/binary --ns-cert=yes ' +
                "#{command_name}#{argument_string}",
                any_args))

    command.execute(
        options.merge(
            netscape_extensions_support: netscape_extensions_support))
  end

  it 'does not include netscape extension support when requested not to' do
    netscape_extensions_support = false
    command = subject.class.new

    expect(Open4).to(
        receive(:spawn)
            .with('path/to/binary --ns-cert=no ' +
                "#{command_name}#{argument_string}",
                any_args))

    command.execute(
        options.merge(
            netscape_extensions_support: netscape_extensions_support))
  end

  it 'includes the provided netscape extension comment' do
    netscape_extensions_comment = 'Some comment'
    command = subject.class.new

    expect(Open4).to(
        receive(:spawn)
            .with('path/to/binary --ns-comment="Some comment" ' +
                "#{command_name}#{argument_string}",
                any_args))

    command.execute(
        options.merge(
            netscape_extensions_comment: netscape_extensions_comment))
  end
end
