# frozen_string_literal: true

require 'lino'

require_relative 'base'
require_relative 'mixins/global_config'
require_relative 'mixins/algorithm_config'
require_relative 'mixins/ssl_config'
require_relative 'mixins/extra_extensions_config'
require_relative 'mixins/encrypt_key_config'

module RubyEasyRSA
  module Commands
    class GenReq < Base
      include Mixins::GlobalConfig
      include Mixins::AlgorithmConfig
      include Mixins::SSLConfig
      include Mixins::ExtraExtensionsConfig
      include Mixins::EncryptKeyConfig

      private

      def configure_command(initial_builder, parameters)
        builder = initial_builder.with_subcommand('gen-req')
        builder = builder.with_argument(parameters[:filename_base])
        super(builder, parameters)
      end
    end
  end
end
