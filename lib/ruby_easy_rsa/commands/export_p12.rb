# frozen_string_literal: true

require 'lino'

require_relative 'base'
require_relative 'mixins/global_config'
require_relative 'mixins/ssl_config'

module RubyEasyRSA
  module Commands
    class ExportP12 < Base
      include Mixins::GlobalConfig
      include Mixins::SSLConfig

      private

      def parameter_defaults(parameters)
        include_ca = parameters[:include_ca]
        include_key = parameters[:include_key]
        super.merge(
          include_ca: include_ca.nil? ? true : include_ca,
          include_key: include_key.nil? ? true : include_key
        )
      end

      def configure_command(initial_builder, parameters)
        builder = super
        builder = builder.with_subcommand('export-p12')
        builder = builder.with_argument(parameters[:filename_base])
        builder = builder.with_argument('noca') unless parameters[:include_ca]
        builder = builder.with_argument('nokey') unless parameters[:include_key]
        builder
      end
    end
  end
end
