# frozen_string_literal: true

module RubyEasyRSA
  module Commands
    module Mixins
      module NetscapeExtensionsConfig
        # rubocop:disable Style/RedundantAssignment
        def configure_command(builder, opts)
          builder = super(builder, opts)
          builder = with_netscape_extensions_support(
            builder, opts[:netscape_extensions_support]
          )
          builder = with_netscape_extensions_comment(
            builder, opts[:netscape_extensions_comment]
          )
          builder
        end
        # rubocop:enable Style/RedundantAssignment

        private

        def with_netscape_extensions_support(
          builder, netscape_extensions_support
        )
          return builder if netscape_extensions_support.nil?

          builder.with_option(
            '--ns-cert', netscape_extensions_support ? 'yes' : 'no'
          )
        end

        def with_netscape_extensions_comment(
          builder, netscape_extensions_comment
        )
          return builder unless netscape_extensions_comment

          builder.with_option(
            '--ns-comment', netscape_extensions_comment, quoting: '"'
          )
        end
      end
    end
  end
end
