# frozen_string_literal: true

shared_examples(
  'a command with algorithm config'
) do |command_name, arguments = [], options = {}|
  let(:argument_string) do
    arguments.empty? ? '' : " #{arguments.join(' ')}"
  end

  it 'uses the provided algorithm when specified' do
    algorithm = 'ec'

    command = described_class.new

    allow(Open4).to(receive(:spawn))

    command.execute(
      options.merge(algorithm:)
    )

    expect(Open4)
      .to(have_received(:spawn)
            .with('path/to/binary --use-algo=ec ' \
                  "#{command_name}#{argument_string}",
                  any_args))
  end

  it 'uses the provided curve when specified' do
    curve = 'sect571k1'

    command = described_class.new

    allow(Open4).to(receive(:spawn))

    command.execute(
      options.merge(curve:)
    )

    expect(Open4)
      .to(have_received(:spawn)
            .with('path/to/binary --curve=sect571k1 ' \
                  "#{command_name}#{argument_string}",
                  any_args))
  end

  it 'uses the provided ec directory when specified' do
    ec_directory = './ec'

    command = described_class.new

    allow(Open4).to(receive(:spawn))

    command.execute(
      options.merge(ec_directory:)
    )

    expect(Open4)
      .to(have_received(:spawn)
            .with('EASYRSA_EC_DIR="./ec" path/to/binary ' \
                  "#{command_name}#{argument_string}",
                  any_args))
  end
end
