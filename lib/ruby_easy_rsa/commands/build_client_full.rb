require 'lino'

require_relative 'base'
require_relative 'mixins/global_config'
require_relative 'mixins/algorithm_config'
require_relative 'mixins/ssl_config'
require_relative 'mixins/sub_ca_config'
require_relative 'mixins/copy_extensions_config'
require_relative 'mixins/extra_extensions_config'
require_relative 'mixins/netscape_extensions_config'
require_relative 'mixins/encrypt_key_config'
require_relative 'mixins/inline_credentials_file_config'

module RubyEasyRSA
  module Commands
    class BuildClientFull < Base
      include Mixins::GlobalConfig
      include Mixins::AlgorithmConfig
      include Mixins::SSLConfig
      include Mixins::SubCAConfig
      include Mixins::CopyExtensionsConfig
      include Mixins::ExtraExtensionsConfig
      include Mixins::NetscapeExtensionsConfig
      include Mixins::EncryptKeyConfig
      include Mixins::InlineCredentialsFileConfig

      def configure_command(builder, opts)
        filename_base = opts[:filename_base]

        builder = builder.with_subcommand('build-client-full')
        builder = builder.with_argument(filename_base)
        builder = super(builder, opts)
        builder
      end
    end
  end
end
