# frozen_string_literal: true

module RubyEasyRSA
  module Commands
    module Mixins
      module SSLConfig
        private

        # rubocop:disable Style/RedundantAssignment
        # rubocop:disable Metrics/MethodLength
        # rubocop:disable Metrics/AbcSize
        def configure_command(initial_builder, parameters)
          builder = super
          builder = with_digest(
            builder, parameters[:digest]
          )
          builder = with_expires_in_days(
            builder, parameters[:expires_in_days]
          )
          builder = with_key_size_in_bits(
            builder, parameters[:key_size_in_bits]
          )
          builder = with_distinguished_name_mode(
            builder, parameters[:distinguished_name_mode]
          )
          builder = with_common_name(
            builder, parameters[:common_name]
          )
          builder = with_country(
            builder, parameters[:country]
          )
          builder = with_province(
            builder, parameters[:province]
          )
          builder = with_city(
            builder, parameters[:city]
          )
          builder = with_organisation(
            builder, parameters[:organisation]
          )
          builder = with_organisational_unit(
            builder, parameters[:organisational_unit]
          )
          builder = with_email(
            builder, parameters[:email]
          )
          builder
        end
        # rubocop:enable Metrics/AbcSize
        # rubocop:enable Metrics/MethodLength
        # rubocop:enable Style/RedundantAssignment

        def with_digest(builder, digest)
          return builder unless digest

          builder.with_option('--digest', digest)
        end

        def with_expires_in_days(builder, expires_in_days)
          return builder unless expires_in_days

          builder.with_option('--days', expires_in_days)
        end

        def with_key_size_in_bits(builder, key_size_in_bits)
          return builder unless key_size_in_bits

          builder.with_option('--keysize', key_size_in_bits)
        end

        def with_distinguished_name_mode(builder, distinguished_name_mode)
          return builder unless distinguished_name_mode

          builder.with_option('--dn-mode', distinguished_name_mode)
        end

        def with_common_name(builder, common_name)
          return builder unless common_name

          builder.with_option('--req-cn', common_name, quoting: '"')
        end

        def with_country(builder, country)
          return builder unless country

          builder.with_option('--req-c', country, quoting: '"')
        end

        def with_province(builder, province)
          return builder unless province

          builder.with_option('--req-st', province, quoting: '"')
        end

        def with_city(builder, city)
          return builder unless city

          builder.with_option('--req-city', city, quoting: '"')
        end

        def with_organisation(builder, organisation)
          return builder unless organisation

          builder.with_option('--req-org', organisation, quoting: '"')
        end

        def with_organisational_unit(builder, organisational_unit)
          return builder unless organisational_unit

          builder.with_option('--req-ou', organisational_unit, quoting: '"')
        end

        def with_email(builder, email)
          return builder unless email

          builder.with_option('--req-email', email)
        end
      end
    end
  end
end
