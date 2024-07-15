# frozen_string_literal: true

require 'lino'

require_relative 'base'
require_relative 'mixins/global_config'
require_relative 'mixins/ssl_config'

module RubyEasyRSA
  module Commands
    class Revoke < Base
      include Mixins::GlobalConfig
      include Mixins::SSLConfig

      private

      def configure_command(initial_builder, parameters)
        builder = super
        builder = builder.with_subcommand('revoke')
        builder = builder.with_argument(parameters[:filename_base])
        if parameters[:reason]
          builder =
            builder.with_argument(parameters[:reason])
        end
        builder
      end
    end
  end
end
