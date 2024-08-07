# frozen_string_literal: true

module RubyEasyRSA
  module Commands
    module Mixins
      module AlgorithmConfig
        private

        # rubocop:disable Style/RedundantAssignment
        def configure_command(initial_builder, parameters)
          builder = super
          builder = with_ec_directory(builder, parameters[:ec_directory])
          builder = with_algorithm(builder, parameters[:algorithm])
          builder = with_curve(builder, parameters[:curve])
          builder
        end
        # rubocop:enable Style/RedundantAssignment

        def with_ec_directory(builder, ec_directory)
          return builder unless ec_directory

          builder.with_environment_variable(
            'EASYRSA_EC_DIR', ec_directory
          )
        end

        def with_algorithm(builder, algorithm)
          return builder unless algorithm

          builder.with_option('--use-algo', algorithm)
        end

        def with_curve(builder, curve)
          return builder unless curve

          builder.with_option('--curve', curve)
        end
      end
    end
  end
end
