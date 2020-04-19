module RubyEasyRSA
  module Commands
    module Mixins
      module ExtraExtensionsConfig
        def configure_command(builder, opts)
          extra_extensions = opts[:extra_extensions]

          builder = super(builder, opts)
          builder = builder.with_environment_variable(
              'EASYRSA_EXTRA_EXT', extra_extensions) if extra_extensions
          builder
        end
      end
    end
  end
end
