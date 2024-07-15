# frozen_string_literal: true

shared_examples(
  'a command with inline credentials file config'
) do |command_name, arguments = [], options = {}|
  let(:argument_string) do
    arguments.empty? ? '' : " #{arguments.join(' ')}"
  end

  it 'passes the inline argument when inline_credentials_file is true' do
    inline_credentials_file = true

    command = described_class.new

    allow(Open4).to(receive(:spawn))

    command.execute(
      options.merge(inline_credentials_file:)
    )

    expect(Open4)
      .to(have_received(:spawn)
            .with("path/to/binary #{command_name}#{argument_string} inline",
                  any_args))
  end

  it 'does not pass the inline argument when inline_credentials_file ' \
     'is false' do
    inline_credentials_file = false

    command = described_class.new

    allow(Open4).to(receive(:spawn))

    command.execute(
      options.merge(inline_credentials_file:)
    )

    expect(Open4)
      .to(have_received(:spawn)
            .with("path/to/binary #{command_name}#{argument_string}",
                  any_args))
  end
end
