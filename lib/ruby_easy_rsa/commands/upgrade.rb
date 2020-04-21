require 'lino'

require_relative 'base'
require_relative 'mixins/global_config'
require_relative 'mixins/ssl_config'

module RubyEasyRSA
  module Commands
    class Upgrade < Base
      include Mixins::GlobalConfig
      include Mixins::SSLConfig

      def configure_command(builder, opts)
        type = opts[:type]

        builder = super(builder, opts)
        builder = builder.with_subcommand('upgrade')
        builder = builder.with_argument(type)
        builder
      end
    end
  end
end
