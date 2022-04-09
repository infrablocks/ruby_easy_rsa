# frozen_string_literal: true

module RubyEasyRSA
  module Commands
    module Mixins
      module SubCAConfig
        # rubocop:disable Style/RedundantAssignment
        def configure_command(builder, opts)
          builder = super(builder, opts)
          builder = with_sub_ca_length(builder, opts[:sub_ca_length])
          builder
        end
        # rubocop:enable Style/RedundantAssignment

        private

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
