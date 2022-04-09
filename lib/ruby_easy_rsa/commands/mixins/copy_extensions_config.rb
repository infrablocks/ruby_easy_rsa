# frozen_string_literal: true

module RubyEasyRSA
  module Commands
    module Mixins
      module CopyExtensionsConfig
        # rubocop:disable Style/RedundantAssignment
        def configure_command(builder, opts)
          builder = super(builder, opts)
          builder = with_copy_extensions(builder, opts[:copy_extensions])
          builder
        end
        # rubocop:enable Style/RedundantAssignment

        private

        def with_copy_extensions(builder, copy_extensions)
          return builder unless copy_extensions

          builder.with_flag('--copy-ext')
        end
      end
    end
  end
end
