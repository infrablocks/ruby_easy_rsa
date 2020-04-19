require 'lino'

require_relative 'base'
require_relative 'mixins/global_config'
require_relative 'mixins/ssl_config'

module RubyEasyRSA
  module Commands
    class ImportReq < Base
      include Mixins::GlobalConfig
      include Mixins::SSLConfig

      def configure_command(builder, opts)
        request_file = opts[:request_file]
        filename_base = opts[:filename_base]

        builder = super(builder, opts)
        builder = builder.with_subcommand('import-req')
        builder = builder.with_argument(request_file)
        builder = builder.with_argument(filename_base)
        builder
      end
    end
  end
end
