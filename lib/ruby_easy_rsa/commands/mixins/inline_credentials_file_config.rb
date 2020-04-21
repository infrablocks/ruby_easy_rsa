module RubyEasyRSA
  module Commands
    module Mixins
      module InlineCredentialsFileConfig
        def configure_command(builder, opts)
          inline_credentials_file = opts[:inline_credentials_file]

          builder = super(builder, opts)
          builder = builder.with_argument('inline') if inline_credentials_file
          builder
        end
      end
    end
  end
end
