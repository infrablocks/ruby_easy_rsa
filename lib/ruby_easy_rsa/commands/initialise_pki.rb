require 'lino'
require_relative 'base'

module RubyEasyRSA
  module Commands
    class InitialisePKI < Base
      def configure_command(builder, opts)
        pki_directory = opts[:pki_directory]

        builder
            .with_subcommand('init-pki') do |sub|
          sub = sub.with_option('--pki-dir', pki_directory) if pki_directory
          sub
        end
      end
    end
  end
end
