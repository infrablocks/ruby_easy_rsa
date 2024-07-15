# frozen_string_literal: true

shared_examples(
  'a command with extra extensions config'
) do |command_name, arguments = [], options = {}|
  let(:argument_string) do
    arguments.empty? ? '' : " #{arguments.join(' ')}"
  end

  it 'includes the provided extra extensions' do
    extra_extensions = 'someExtraExtension = value'

    command = described_class.new

    allow(Open4).to(receive(:spawn))

    command.execute(
      options.merge(extra_extensions:)
    )

    expect(Open4)
      .to(have_received(:spawn)
            .with('EASYRSA_EXTRA_EXT="someExtraExtension = value" ' \
                  "path/to/binary #{command_name}#{argument_string}",
                  any_args))
  end

  it 'includes the provided subject alternative name' do
    subject_alternative_name = 'some.name.example.com'

    command = described_class.new

    allow(Open4).to(receive(:spawn))

    command.execute(
      options.merge(
        subject_alternative_name:
      )
    )

    expect(Open4)
      .to(have_received(:spawn)
            .with('path/to/binary ' \
                  '--subject-alt-name="some.name.example.com" ' \
                  "#{command_name}#{argument_string}",
                  any_args))
  end
end
