# frozen_string_literal: true

require 'lino'

require_relative 'base'
require_relative 'mixins/global_config'
require_relative 'mixins/ssl_config'

module RubyEasyRSA
  module Commands
    class ShowCert < Base
      include Mixins::GlobalConfig
      include Mixins::SSLConfig

      private

      def configure_command(initial_builder, parameters)
        builder = super
        builder = builder.with_subcommand('show-cert')
        builder = builder.with_argument(parameters[:filename_base])
        builder = builder.with_argument('full') if parameters[:full]
        builder
      end
    end
  end
end
