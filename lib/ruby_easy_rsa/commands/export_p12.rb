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

      def configure_command(builder, opts)
        filename_base = opts[:filename_base]
        include_ca = opts[:include_ca].nil? ? true : opts[:include_ca]
        include_key = opts[:include_key].nil? ? true : opts[:include_key]

        builder = super(builder, opts)
        builder = builder.with_subcommand('export-p12')
        builder = builder.with_argument(filename_base)
        builder = builder.with_argument('noca') unless include_ca
        builder = builder.with_argument('nokey') unless include_key
        builder
      end
    end
  end
end
