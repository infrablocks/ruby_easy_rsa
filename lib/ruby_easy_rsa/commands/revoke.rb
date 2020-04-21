require 'lino'

require_relative 'base'
require_relative 'mixins/global_config'
require_relative 'mixins/ssl_config'

module RubyEasyRSA
  module Commands
    class Revoke < Base
      include Mixins::GlobalConfig
      include Mixins::SSLConfig

      def configure_command(builder, opts)
        filename_base = opts[:filename_base]
        reason = opts[:reason]

        builder = super(builder, opts)
        builder = builder.with_subcommand('revoke')
        builder = builder.with_argument(filename_base)
        builder = builder.with_argument(reason) if reason
        builder
      end
    end
  end
end
