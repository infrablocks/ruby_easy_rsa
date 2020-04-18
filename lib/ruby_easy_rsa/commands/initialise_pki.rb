require 'lino'
require_relative 'base'

module RubyEasyRSA
  module Commands
    class InitialisePKI < Base
      def configure_command(builder, opts)
        builder
            .with_subcommand('init-pki')
      end
    end
  end
end