module RubyEasyRSA
  module Commands
    module Mixins
      module EncryptKeyConfig
        def configure_command(builder, opts)
          encrypt_key = opts[:encrypt_key].nil? ? true : opts[:encrypt_key]

          builder = super(builder, opts)
          builder = builder.with_argument('nopass') unless encrypt_key
          builder
        end
      end
    end
  end
end
