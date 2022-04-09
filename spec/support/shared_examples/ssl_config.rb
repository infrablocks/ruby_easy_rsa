# frozen_string_literal: true

shared_examples(
  'a command with ssl config'
) do |command_name, arguments = [], options = {}|
  let(:argument_string) do
    arguments.empty? ? '' : " #{arguments.join(' ')}"
  end

  it 'uses the provided CA expiration time when specified' do
    expires_in_days = '90'

    command = described_class.new

    allow(Open4).to(receive(:spawn))

    command.execute(
      options.merge(expires_in_days: expires_in_days)
    )

    expect(Open4)
      .to(have_received(:spawn)
            .with("path/to/binary --days=90 #{command_name}#{argument_string}",
                  any_args))
  end

  it 'uses the provided digest when specified' do
    digest = 'sha512'

    command = described_class.new

    allow(Open4).to(receive(:spawn))

    command.execute(
      options.merge(digest: digest)
    )

    expect(Open4)
      .to(have_received(:spawn)
            .with('path/to/binary --digest=sha512 ' \
                  "#{command_name}#{argument_string}",
                  any_args))
  end

  it 'uses the provided distinguished name mode when specified' do
    distinguished_name_mode = 'org'

    command = described_class.new

    allow(Open4).to(receive(:spawn))

    command.execute(
      options.merge(distinguished_name_mode: distinguished_name_mode)
    )

    expect(Open4)
      .to(have_received(:spawn)
            .with('path/to/binary --dn-mode=org ' \
                  "#{command_name}#{argument_string}",
                  any_args))
  end

  it 'uses the provided common name when specified' do
    common_name = 'server.example.com'

    command = described_class.new

    allow(Open4).to(receive(:spawn))

    command.execute(
      options.merge(common_name: common_name)
    )

    expect(Open4)
      .to(have_received(:spawn)
            .with('path/to/binary --req-cn="server.example.com" ' \
                  "#{command_name}#{argument_string}",
                  any_args))
  end

  it 'uses the provided country when specified' do
    country = 'GB'

    command = described_class.new

    allow(Open4).to(receive(:spawn))

    command.execute(
      options.merge(country: country)
    )

    expect(Open4)
      .to(have_received(:spawn)
            .with('path/to/binary --req-c="GB" ' \
                  "#{command_name}#{argument_string}",
                  any_args))
  end

  it 'uses the provided province when specified' do
    province = 'Greater London'

    command = described_class.new

    allow(Open4).to(receive(:spawn))

    command.execute(
      options.merge(province: province)
    )

    expect(Open4)
      .to(have_received(:spawn)
            .with('path/to/binary --req-st="Greater London" ' \
                  "#{command_name}#{argument_string}",
                  any_args))
  end

  it 'uses the provided city when specified' do
    city = 'London'

    command = described_class.new

    allow(Open4).to(receive(:spawn))

    command.execute(
      options.merge(city: city)
    )

    expect(Open4)
      .to(have_received(:spawn)
            .with('path/to/binary --req-city="London" ' \
                  "#{command_name}#{argument_string}",
                  any_args))
  end

  it 'uses the provided organisation when specified' do
    organisation = 'Company Ltd.'

    command = described_class.new

    allow(Open4).to(receive(:spawn))

    command.execute(
      options.merge(organisation: organisation)
    )

    expect(Open4)
      .to(have_received(:spawn)
            .with('path/to/binary --req-org="Company Ltd." ' \
                  "#{command_name}#{argument_string}",
                  any_args))
  end

  it 'uses the provided organisational unit when specified' do
    organisational_unit = 'Finance'

    command = described_class.new

    allow(Open4).to(receive(:spawn))

    command.execute(
      options.merge(organisational_unit: organisational_unit)
    )

    expect(Open4)
      .to(have_received(:spawn)
            .with('path/to/binary --req-ou="Finance" ' \
                  "#{command_name}#{argument_string}",
                  any_args))
  end

  it 'uses the provided email when specified' do
    email = 'someone@example.com'

    command = described_class.new

    allow(Open4).to(receive(:spawn))

    command.execute(
      options.merge(email: email)
    )

    expect(Open4)
      .to(have_received(:spawn)
            .with('path/to/binary --req-email=someone@example.com ' \
                  "#{command_name}#{argument_string}",
                  any_args))
  end
end
