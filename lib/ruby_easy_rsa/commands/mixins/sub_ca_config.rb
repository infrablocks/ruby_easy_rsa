module RubyEasyRSA
  module Commands
    module Mixins
      module SubCAConfig
        def configure_command(builder, opts)
          sub_ca_length = opts[:sub_ca_length]

          builder = super(builder, opts)
          builder = builder.with_option(
              '--subca-len', sub_ca_length) if sub_ca_length
          builder
        end
      end
    end
  end
end
