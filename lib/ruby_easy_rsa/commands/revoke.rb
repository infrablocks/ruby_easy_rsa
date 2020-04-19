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

        builder = builder.with_subcommand('revoke')
        builder = builder.with_argument(filename_base)
        builder = super(builder, opts)
        builder
      end
    end
  end
end
