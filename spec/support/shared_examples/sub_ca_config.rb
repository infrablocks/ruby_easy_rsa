# frozen_string_literal: true

shared_examples(
  'a command with sub-CA config'
) do |command_name, arguments = [], options = {}|
  let(:argument_string) do
    arguments.empty? ? '' : " #{arguments.join(' ')}"
  end

  it 'uses the provided sub-CA length' do
    sub_ca_length = 10

    command = described_class.new

    allow(Open4).to(receive(:spawn))

    command.execute(
      options.merge(sub_ca_length: sub_ca_length)
    )

    expect(Open4)
      .to(have_received(:spawn)
            .with('path/to/binary --subca-len=10 ' \
                  "#{command_name}#{argument_string}",
                  any_args))
  end
end
