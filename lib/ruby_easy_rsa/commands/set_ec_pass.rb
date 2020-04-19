require 'lino'

require_relative 'base'
require_relative 'mixins/global_config'
require_relative 'mixins/ssl_config'
require_relative 'mixins/encrypt_key_config'

module RubyEasyRSA
  module Commands
    class SetECPass < Base
      include Mixins::GlobalConfig
      include Mixins::SSLConfig
      include Mixins::EncryptKeyConfig

      def configure_command(builder, opts)
        filename_base = opts[:filename_base]
        file = opts[:file]

        builder = builder.with_subcommand('set-ec-pass')
        builder = builder.with_argument(filename_base)
        builder = super(builder, opts)
        builder = builder.with_argument('file') if file
        builder
      end
    end
  end
end
