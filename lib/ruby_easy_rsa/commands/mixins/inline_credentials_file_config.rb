# frozen_string_literal: true

module RubyEasyRSA
  module Commands
    module Mixins
      module InlineCredentialsFileConfig
        # rubocop:disable Style/RedundantAssignment
        def configure_command(builder, opts)
          builder = super(builder, opts)
          builder = with_inline_credentials_file(
            builder, opts[:inline_credentials_file]
          )
          builder
        end
        # rubocop:enable Style/RedundantAssignment

        private

        def with_inline_credentials_file(builder, inline_credentials_file)
          return builder unless inline_credentials_file

          builder.with_argument('inline')
        end
      end
    end
  end
end
