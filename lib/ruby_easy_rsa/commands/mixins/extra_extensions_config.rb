module RubyEasyRSA
  module Commands
    module Mixins
      module ExtraExtensionsConfig
        def configure_command(builder, opts)
          extra_extensions = opts[:extra_extensions]
          subject_alternative_name = opts[:subject_alternative_name]

          builder = super(builder, opts)
          builder = builder.with_environment_variable(
              'EASYRSA_EXTRA_EXT', extra_extensions) if extra_extensions
          builder = builder.with_option(
              '--subject-alt-name', subject_alternative_name, quoting: '"'
          ) if subject_alternative_name
          builder
        end
      end
    end
  end
end
