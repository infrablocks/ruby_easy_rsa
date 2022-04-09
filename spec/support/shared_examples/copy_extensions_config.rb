# frozen_string_literal: true

shared_examples(
  'a command with copy extensions config'
) do |command_name, arguments = [], options = {}|
  let(:argument_string) do
    arguments.empty? ? '' : " #{arguments.join(' ')}"
  end

  it 'includes the copy-ext switch when copy extensions is true' do
    command = described_class.new

    allow(Open4).to(receive(:spawn))

    command.execute(
      options.merge(copy_extensions: true)
    )

    expect(Open4)
      .to(have_received(:spawn)
            .with("path/to/binary --copy-ext #{command_name}#{argument_string}",
                  any_args))
  end

  it 'does not include the copy-ext switch when copy extensions is false' do
    command = described_class.new

    allow(Open4).to(receive(:spawn))

    command.execute(
      options.merge(copy_extensions: false)
    )

    expect(Open4)
      .to(have_received(:spawn)
            .with("path/to/binary #{command_name}#{argument_string}",
                  any_args))
  end
end
