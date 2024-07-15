# frozen_string_literal: true

module RubyEasyRSA
  module Commands
    module Mixins
      module EncryptKeyConfig
        private

        # rubocop:disable Style/RedundantAssignment
        def configure_command(initial_builder, parameters)
          builder = super
          builder = with_encrypt_key(builder, encrypt_key(parameters))
          builder
        end
        # rubocop:enable Style/RedundantAssignment

        def encrypt_key(opts)
          opts[:encrypt_key].nil? ? true : opts[:encrypt_key]
        end

        def with_encrypt_key(builder, encrypt_key)
          return builder if encrypt_key

          builder.with_argument('nopass')
        end
      end
    end
  end
end
