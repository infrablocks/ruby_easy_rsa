shared_examples "a command with algorithm config" do |command_name, arguments = [], options = {}|
  let(:argument_string) do
    arguments.empty? ? "" : " #{arguments.join(" ")}"
  end

  it 'uses the provided algorithm when specified' do
    algorithm = "ec"

    command = subject.class.new

    expect(Open4).to(
        receive(:spawn)
            .with("path/to/binary --use-algo=ec " +
                "#{command_name}#{argument_string}",
                any_args))

    command.execute(
        options.merge(algorithm: algorithm))
  end

  it 'uses the provided curve when specified' do
    curve = "sect571k1"

    command = subject.class.new

    expect(Open4).to(
        receive(:spawn)
            .with("path/to/binary --curve=sect571k1 " +
                "#{command_name}#{argument_string}",
                any_args))

    command.execute(
        options.merge(curve: curve))
  end

  it 'uses the provided ec directory when specified' do
    ec_directory = "./ec"

    command = subject.class.new

    expect(Open4).to(
        receive(:spawn)
            .with("EASYRSA_EC_DIR=\"./ec\" path/to/binary " +
                "#{command_name}#{argument_string}",
                any_args))

    command.execute(
        options.merge(ec_directory: ec_directory))
  end
end
