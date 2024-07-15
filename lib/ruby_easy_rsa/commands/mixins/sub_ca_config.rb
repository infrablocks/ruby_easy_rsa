# frozen_string_literal: true

module RubyEasyRSA
  module Commands
    module Mixins
      module SubCAConfig
        private

        # rubocop:disable Style/RedundantAssignment
        def configure_command(initial_builder, parameters)
          builder = super
          builder = with_sub_ca_length(builder, parameters[:sub_ca_length])
          builder
        end
        # rubocop:enable Style/RedundantAssignment

        def with_sub_ca_length(builder, sub_ca_length)
          return builder unless sub_ca_length

          builder.with_option(
            '--subca-len', sub_ca_length
          )
        end
      end
    end
  end
end
