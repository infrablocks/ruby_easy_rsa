module RubyEasyRSA
  module Commands
    module Mixins
      module AlgoConfig
        def configure_command(builder, opts)
          algorithm = opts[:algorithm]
          curve = opts[:curve]
          ec_directory = opts[:ec_directory]

          builder = super(builder, opts)
          builder = builder.with_environment_variable(
              'EASYRSA_EC_DIR', ec_directory) if ec_directory
          builder = builder.with_option('--use-algo', algorithm) if algorithm
          builder = builder.with_option('--curve', curve) if curve
          builder
        end
      end
    end
  end
end
