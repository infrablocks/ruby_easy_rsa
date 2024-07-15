# frozen_string_literal: true

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

      private

      def configure_command(initial_builder, parameters)
        builder = initial_builder.with_subcommand('build-client-full')
        builder = builder.with_argument(parameters[:filename_base])
        super(builder, parameters)
      end
    end
  end
end
