# frozen_string_literal: true

module RubyEasyRSA
  module Commands
    module Mixins
      module CopyExtensionsConfig
        private

        # rubocop:disable Style/RedundantAssignment
        def configure_command(initial_builder, parameters)
          builder = super
          builder = with_copy_extensions(builder, parameters[:copy_extensions])
          builder
        end
        # rubocop:enable Style/RedundantAssignment

        def with_copy_extensions(builder, copy_extensions)
          return builder unless copy_extensions

          builder.with_flag('--copy-ext')
        end
      end
    end
  end
end
