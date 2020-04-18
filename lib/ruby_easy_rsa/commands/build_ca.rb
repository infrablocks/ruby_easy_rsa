require 'lino'

require_relative 'base'
require_relative 'mixins/global_config'
require_relative 'mixins/ssl_config'

module RubyEasyRSA
  module Commands
    class BuildCA < Base
      include Mixins::GlobalConfig
      include Mixins::SSLConfig

      def configure_command(builder, opts)
        algorithm = opts[:algorithm]
        batch = opts[:batch]
        encrypt_key = opts[:encrypt_key].nil? ? true : opts[:encrypt_key]
        sub_ca = opts[:sub_ca]

        builder = super(builder, opts)
        builder = builder.with_option('--use-algo', algorithm) if algorithm
        builder = builder.with_flag('--batch') if batch
        builder = builder.with_subcommand('build-ca')
        builder = builder.with_argument('nopass') unless encrypt_key
        builder = builder.with_argument('subca') if sub_ca
        builder
      end
    end
  end
end
