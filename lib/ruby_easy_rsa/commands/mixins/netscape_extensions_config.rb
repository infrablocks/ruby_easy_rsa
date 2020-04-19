module RubyEasyRSA
  module Commands
    module Mixins
      module NetscapeExtensionsConfig
        def configure_command(builder, opts)
          netscape_extensions_support = opts[:netscape_extensions_support]
          netscape_extensions_comment = opts[:netscape_extensions_comment]

          builder = super(builder, opts)
          builder = builder.with_option(
              '--ns-cert', netscape_extensions_support ? 'yes' : 'no'
          ) unless netscape_extensions_support.nil?
          builder = builder.with_option(
              '--ns-comment', netscape_extensions_comment, quoting: '"'
          ) if netscape_extensions_comment
          builder
        end
      end
    end
  end
end
