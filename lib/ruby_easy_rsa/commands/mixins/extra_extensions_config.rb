# frozen_string_literal: true

module RubyEasyRSA
  module Commands
    module Mixins
      module ExtraExtensionsConfig
        private

        # rubocop:disable Style/RedundantAssignment
        def configure_command(initial_builder, parameters)
          builder = super
          builder = with_extra_extensions(
            builder, parameters[:extra_extensions]
          )
          builder = with_subject_alternative_name(
            builder, parameters[:subject_alternative_name]
          )
          builder
        end
        # rubocop:enable Style/RedundantAssignment

        def with_extra_extensions(builder, extra_extensions)
          return builder unless extra_extensions

          builder.with_environment_variable(
            'EASYRSA_EXTRA_EXT', extra_extensions
          )
        end

        def with_subject_alternative_name(builder, subject_alternative_name)
          return builder unless subject_alternative_name

          builder.with_option(
            '--subject-alt-name', subject_alternative_name, quoting: '"'
          )
        end
      end
    end
  end
end
