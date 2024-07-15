# frozen_string_literal: true

require 'lino'

require_relative 'base'
require_relative 'mixins/global_config'
require_relative 'mixins/ssl_config'

module RubyEasyRSA
  module Commands
    class ImportReq < Base
      include Mixins::GlobalConfig
      include Mixins::SSLConfig

      private

      def configure_command(initial_builder, parameters)
        request_file = parameters[:request_file]
        filename_base = parameters[:filename_base]

        builder = super
        builder = builder.with_subcommand('import-req')
        builder = builder.with_argument(request_file)
        builder.with_argument(filename_base)
      end
    end
  end
end
