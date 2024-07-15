# frozen_string_literal: true

require 'lino'

require_relative 'base'
require_relative 'mixins/global_config'
require_relative 'mixins/algorithm_config'
require_relative 'mixins/ssl_config'
require_relative 'mixins/sub_ca_config'
require_relative 'mixins/copy_extensions_config'
require_relative 'mixins/extra_extensions_config'
require_relative 'mixins/netscape_extensions_config'

module RubyEasyRSA
  module Commands
    class SignReq < Base
      include Mixins::GlobalConfig
      include Mixins::AlgorithmConfig
      include Mixins::SSLConfig
      include Mixins::SubCAConfig
      include Mixins::CopyExtensionsConfig
      include Mixins::ExtraExtensionsConfig
      include Mixins::NetscapeExtensionsConfig

      private

      def configure_command(initial_builder, parameters)
        builder = super
        builder = builder.with_subcommand('sign-req')
        builder = builder.with_argument(parameters[:type])
        builder.with_argument(parameters[:filename_base])
      end
    end
  end
end
