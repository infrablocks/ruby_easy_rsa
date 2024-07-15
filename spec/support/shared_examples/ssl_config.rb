# frozen_string_literal: true

shared_examples(
  'a command with ssl config'
) do |command_name, arguments = [], options = {}|
  let(:argument_string) { arguments.empty? ? '' : " #{arguments.join(' ')}" }
  let(:executor) { Lino::Executors::Mock.new }

  before do
    Lino.configure do |config|
      config.executor = executor
    end
  end

  after do
    Lino.reset!
  end

  it 'uses the provided CA expiration time when specified' do
    expires_in_days = '90'

    command = described_class.new

    command.execute(
      options.merge(expires_in_days:)
    )

    expect(executor.executions.first.command_line.string)
      .to(eq("path/to/binary --days=90 #{command_name}#{argument_string}"))
  end

  it 'uses the provided digest when specified' do
    digest = 'sha512'

    command = described_class.new

    command.execute(
      options.merge(digest:)
    )

    expect(executor.executions.first.command_line.string)
      .to(eq('path/to/binary --digest=sha512 ' \
             "#{command_name}#{argument_string}"))
  end

  it 'uses the provided distinguished name mode when specified' do
    distinguished_name_mode = 'org'

    command = described_class.new

    command.execute(
      options.merge(distinguished_name_mode:)
    )

    expect(executor.executions.first.command_line.string)
      .to(eq('path/to/binary --dn-mode=org ' \
             "#{command_name}#{argument_string}"))
  end

  it 'uses the provided common name when specified' do
    common_name = 'server.example.com'

    command = described_class.new

    command.execute(
      options.merge(common_name:)
    )

    expect(executor.executions.first.command_line.string)
      .to(eq('path/to/binary --req-cn="server.example.com" ' \
             "#{command_name}#{argument_string}"))
  end

  it 'uses the provided country when specified' do
    country = 'GB'

    command = described_class.new

    command.execute(
      options.merge(country:)
    )

    expect(executor.executions.first.command_line.string)
      .to(eq('path/to/binary --req-c="GB" ' \
             "#{command_name}#{argument_string}"))
  end

  it 'uses the provided province when specified' do
    province = 'Greater London'

    command = described_class.new

    command.execute(
      options.merge(province:)
    )

    expect(executor.executions.first.command_line.string)
      .to(eq('path/to/binary --req-st="Greater London" ' \
             "#{command_name}#{argument_string}"))
  end

  it 'uses the provided city when specified' do
    city = 'London'

    command = described_class.new

    command.execute(
      options.merge(city:)
    )

    expect(executor.executions.first.command_line.string)
      .to(eq('path/to/binary --req-city="London" ' \
             "#{command_name}#{argument_string}"))
  end

  it 'uses the provided organisation when specified' do
    organisation = 'Company Ltd.'

    command = described_class.new

    command.execute(
      options.merge(organisation:)
    )

    expect(executor.executions.first.command_line.string)
      .to(eq('path/to/binary --req-org="Company Ltd." ' \
             "#{command_name}#{argument_string}"))
  end

  it 'uses the provided organisational unit when specified' do
    organisational_unit = 'Finance'

    command = described_class.new

    command.execute(
      options.merge(organisational_unit:)
    )

    expect(executor.executions.first.command_line.string)
      .to(eq('path/to/binary --req-ou="Finance" ' \
             "#{command_name}#{argument_string}"))
  end

  it 'uses the provided email when specified' do
    email = 'someone@example.com'

    command = described_class.new

    command.execute(
      options.merge(email:)
    )

    expect(executor.executions.first.command_line.string)
      .to(eq('path/to/binary --req-email=someone@example.com ' \
             "#{command_name}#{argument_string}"))
  end
end
