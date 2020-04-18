require 'lino'

require_relative 'base'
require_relative 'mixins/global_config'
require_relative 'mixins/ssl_config'

module RubyEasyRSA
  module Commands
    class InitPKI < Base
      include Mixins::GlobalConfig
      include Mixins::SSLConfig

      def configure_command(builder, opts)
        builder = super(builder, opts)
        builder.with_subcommand('init-pki')
      end
    end
  end
end
