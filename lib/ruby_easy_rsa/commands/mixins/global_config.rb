# frozen_string_literal: true

module RubyEasyRSA
  module Commands
    module Mixins
      module GlobalConfig
        private

        # rubocop:disable Style/RedundantAssignment
        # rubocop:disable Metrics/MethodLength
        # rubocop:disable Metrics/AbcSize
        def configure_command(initial_builder, parameters)
          builder = super
          builder = with_openssl_binary(
            builder, parameters[:openssl_binary]
          )
          builder = with_extensions_directory(
            builder, parameters[:extensions_directory]
          )
          builder = with_ssl_configuration(
            builder, parameters[:ssl_configuration]
          )
          builder = with_safe_configuration(
            builder, parameters[:safe_configuration]
          )
          builder = with_vars(
            builder, parameters[:vars]
          )
          builder = with_batch(
            builder, parameters[:batch]
          )
          builder = with_pki_directory(
            builder, parameters[:pki_directory]
          )
          builder = with_input_password(
            builder, parameters[:input_password]
          )
          builder = with_output_password(
            builder, parameters[:output_password]
          )
          builder
        end
        # rubocop:enable Metrics/AbcSize
        # rubocop:enable Metrics/MethodLength
        # rubocop:enable Style/RedundantAssignment

        def with_openssl_binary(builder, openssl_binary)
          return builder unless openssl_binary

          builder.with_environment_variable(
            'EASYRSA_OPENSSL', openssl_binary
          )
        end

        def with_extensions_directory(builder, extensions_directory)
          return builder unless extensions_directory

          builder.with_environment_variable(
            'EASYRSA_EXT_DIR', extensions_directory
          )
        end

        def with_ssl_configuration(builder, ssl_configuration)
          return builder unless ssl_configuration

          builder.with_environment_variable(
            'EASYRSA_SSL_CONF', ssl_configuration
          )
        end

        def with_safe_configuration(builder, safe_configuration)
          return builder unless safe_configuration

          builder.with_environment_variable(
            'EASYRSA_SAFE_CONF', safe_configuration
          )
        end

        def with_vars(builder, vars)
          return builder unless vars

          builder.with_option(
            '--vars', vars
          )
        end

        def with_batch(builder, batch)
          return builder unless batch

          builder.with_flag(
            '--batch'
          )
        end

        def with_pki_directory(builder, pki_directory)
          return builder unless pki_directory

          builder.with_option(
            '--pki-dir', pki_directory
          )
        end

        def with_input_password(builder, input_password)
          return builder unless input_password

          builder.with_option(
            '--passin', input_password
          )
        end

        def with_output_password(builder, output_password)
          return builder unless output_password

          builder.with_option(
            '--passout', output_password
          )
        end
      end
    end
  end
end
