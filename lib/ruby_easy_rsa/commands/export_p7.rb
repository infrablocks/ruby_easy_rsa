# frozen_string_literal: true

require 'lino'

require_relative 'base'
require_relative 'mixins/global_config'
require_relative 'mixins/ssl_config'

module RubyEasyRSA
  module Commands
    class ExportP7 < Base
      include Mixins::GlobalConfig
      include Mixins::SSLConfig

      def configure_command(builder, opts)
        filename_base = opts[:filename_base]
        include_ca = opts[:include_ca].nil? ? true : opts[:include_ca]

        builder = super(builder, opts)
        builder = builder.with_subcommand('export-p7')
        builder = builder.with_argument(filename_base)
        builder = builder.with_argument('noca') unless include_ca
        builder
      end
    end
  end
end
