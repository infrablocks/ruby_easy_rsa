module RubyEasyRSA
  module Commands
    module Mixins
      module GlobalConfig
        def configure_command(builder, opts)
          pki_directory = opts[:pki_directory]
          extensions_directory = opts[:extensions_directory]
          openssl_binary = opts[:openssl_binary]
          ssl_configuration = opts[:ssl_configuration]
          safe_configuration = opts[:safe_configuration]
          vars = opts[:vars]

          builder = super(builder, opts)
          builder = builder.with_environment_variable(
              'EASYRSA_OPENSSL', openssl_binary) if openssl_binary
          builder = builder.with_environment_variable(
              'EASYRSA_EXT_DIR', extensions_directory) if extensions_directory
          builder = builder.with_environment_variable(
              'EASYRSA_SSL_CONF', ssl_configuration) if ssl_configuration
          builder = builder.with_environment_variable(
              'EASYRSA_SAFE_CONF', safe_configuration) if safe_configuration
          builder = builder.with_option(
              '--vars', vars) if vars
          builder = builder.with_option(
              '--pki-dir', pki_directory) if pki_directory
          builder
        end
      end
    end
  end
end