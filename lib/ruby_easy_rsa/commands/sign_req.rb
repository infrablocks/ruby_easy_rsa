require 'lino'

require_relative 'base'
require_relative 'mixins/global_config'
require_relative 'mixins/algorithm_config'
require_relative 'mixins/ssl_config'
require_relative 'mixins/extra_extensions_config'
require_relative 'mixins/netscape_extensions_config'

module RubyEasyRSA
  module Commands
    class SignReq < Base
      include Mixins::GlobalConfig
      include Mixins::SSLConfig
      include Mixins::AlgorithmConfig
      include Mixins::ExtraExtensionsConfig
      include Mixins::NetscapeExtensionsConfig

      def configure_command(builder, opts)
        type = opts[:type]
        filename_base = opts[:filename_base]
        sub_ca_length = opts[:sub_ca_length]
        copy_extensions = opts[:copy_extensions]

        builder = super(builder, opts)
        builder = builder.with_flag(
            '--copy-ext') if copy_extensions
        builder = builder.with_option(
            '--subca-len', sub_ca_length) if sub_ca_length
        builder = builder.with_subcommand('sign-req')
        builder = builder.with_argument(type)
        builder = builder.with_argument(filename_base)
        builder
      end
    end
  end
end
