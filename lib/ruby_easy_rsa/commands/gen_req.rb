require 'lino'

require_relative 'base'
require_relative 'mixins/global_config'
require_relative 'mixins/ssl_config'
require_relative 'mixins/algorithm_config'

module RubyEasyRSA
  module Commands
    class GenReq < Base
      include Mixins::GlobalConfig
      include Mixins::SSLConfig
      include Mixins::AlgorithmConfig

      def configure_command(builder, opts)
        batch = opts[:batch]
        filename_base = opts[:filename_base]
        encrypt_key = opts[:encrypt_key].nil? ? true : opts[:encrypt_key]

        builder = super(builder, opts)
        builder = builder.with_flag('--batch') if batch
        builder = builder.with_subcommand('gen-req')
        builder = builder.with_argument(filename_base)
        builder = builder.with_argument('nopass') unless encrypt_key
        builder
      end
    end
  end
end
