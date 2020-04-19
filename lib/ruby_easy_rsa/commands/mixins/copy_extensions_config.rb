module RubyEasyRSA
  module Commands
    module Mixins
      module CopyExtensionsConfig
        def configure_command(builder, opts)
          copy_extensions = opts[:copy_extensions]

          builder = super(builder, opts)
          builder = builder.with_flag('--copy-ext') if copy_extensions
          builder
        end
      end
    end
  end
end
