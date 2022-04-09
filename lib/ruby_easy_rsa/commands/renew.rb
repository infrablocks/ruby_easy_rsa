# frozen_string_literal: true

require 'lino'

require_relative 'base'
require_relative 'mixins/global_config'
require_relative 'mixins/ssl_config'
require_relative 'mixins/encrypt_key_config'

module RubyEasyRSA
  module Commands
    class Renew < Base
      include Mixins::GlobalConfig
      include Mixins::SSLConfig
      include Mixins::EncryptKeyConfig

      def configure_command(builder, opts)
        filename_base = opts[:filename_base]

        builder = builder.with_subcommand('renew')
        builder = builder.with_argument(filename_base)
        super(builder, opts)
      end
    end
  end
end
