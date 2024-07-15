# frozen_string_literal: true

shared_examples(
  'a command with encrypt key config'
) do |command_name, arguments = [], options = {}|
  let(:argument_string) do
    arguments.empty? ? '' : " #{arguments.join(' ')}"
  end

  it 'passes the nopass argument when encrypt_key is false' do
    encrypt_key = false

    command = described_class.new

    allow(Open4).to(receive(:spawn))

    command.execute(
      options.merge(encrypt_key:)
    )

    expect(Open4)
      .to(have_received(:spawn)
            .with("path/to/binary #{command_name}#{argument_string} nopass",
                  any_args))
  end

  it 'does not pass the nopass argument when encrypt_key is true' do
    encrypt_key = true

    command = described_class.new

    allow(Open4).to(receive(:spawn))

    command.execute(
      options.merge(encrypt_key:)
    )

    expect(Open4)
      .to(have_received(:spawn)
            .with("path/to/binary #{command_name}#{argument_string}",
                  any_args))
  end
end
