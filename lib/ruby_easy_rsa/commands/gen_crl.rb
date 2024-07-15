# frozen_string_literal: true

require 'lino'

require_relative 'base'
require_relative 'mixins/global_config'
require_relative 'mixins/ssl_config'

module RubyEasyRSA
  module Commands
    class GenCRL < Base
      include Mixins::GlobalConfig
      include Mixins::SSLConfig

      private

      def configure_command(initial_builder, parameters)
        builder = initial_builder.with_subcommand('gen-crl')
        super(builder, parameters)
      end
    end
  end
end
