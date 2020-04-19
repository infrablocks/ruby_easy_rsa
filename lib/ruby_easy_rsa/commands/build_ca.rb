require 'lino'

require_relative 'base'
require_relative 'mixins/global_config'
require_relative 'mixins/ssl_config'
require_relative 'mixins/algorithm_config'
require_relative 'mixins/encrypt_key_config'

module RubyEasyRSA
  module Commands
    class BuildCA < Base
      include Mixins::GlobalConfig
      include Mixins::SSLConfig
      include Mixins::AlgorithmConfig
      include Mixins::EncryptKeyConfig

      def configure_command(builder, opts)
        sub_ca = opts[:sub_ca]

        builder = builder.with_subcommand('build-ca')
        builder = builder.with_argument('subca') if sub_ca
        builder = super(builder, opts)
        builder
      end
    end
  end
end
