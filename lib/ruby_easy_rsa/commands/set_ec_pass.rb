# frozen_string_literal: true

require 'lino'

require_relative 'base'
require_relative 'mixins/global_config'
require_relative 'mixins/ssl_config'
require_relative 'mixins/encrypt_key_config'

module RubyEasyRSA
  module Commands
    class SetECPass < Base
      include Mixins::GlobalConfig
      include Mixins::SSLConfig
      include Mixins::EncryptKeyConfig

      private

      def configure_command(initial_builder, parameters)
        builder = initial_builder.with_subcommand('set-ec-pass')
        builder = builder.with_argument(parameters[:filename_base])
        builder = super(builder, parameters)
        builder = builder.with_argument('file') if parameters[:file]
        builder
      end
    end
  end
end
