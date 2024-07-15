# frozen_string_literal: true

module RubyEasyRSA
  module Commands
    module Mixins
      module InlineCredentialsFileConfig
        private

        # rubocop:disable Style/RedundantAssignment
        def configure_command(initial_builder, parameters)
          builder = super
          builder = with_inline_credentials_file(
            builder, parameters[:inline_credentials_file]
          )
          builder
        end
        # rubocop:enable Style/RedundantAssignment

        def with_inline_credentials_file(builder, inline_credentials_file)
          return builder unless inline_credentials_file

          builder.with_argument('inline')
        end
      end
    end
  end
end
