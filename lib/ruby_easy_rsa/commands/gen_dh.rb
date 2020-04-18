require 'lino'

require_relative 'base'
require_relative 'mixins/global_config'
require_relative 'mixins/ssl_config'

module RubyEasyRSA
  module Commands
    class GenDH < Base
      include Mixins::GlobalConfig
      include Mixins::SSLConfig

      def configure_command(builder, opts)
        builder = super(builder, opts)
        builder = builder.with_subcommand('gen-dh')
        builder
      end
    end
  end
end
