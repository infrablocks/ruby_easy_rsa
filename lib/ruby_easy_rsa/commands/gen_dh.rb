# frozen_string_literal: true

require 'lino'

require_relative 'base'
require_relative 'mixins/global_config'
require_relative 'mixins/ssl_config'

module RubyEasyRSA
  module Commands
    class GenDH < Base
      include Mixins::GlobalConfig
      include Mixins::SSLConfig

      private

      def configure_command(initial_builder, parameters)
        builder = super
        builder.with_subcommand('gen-dh')
      end
    end
  end
end
