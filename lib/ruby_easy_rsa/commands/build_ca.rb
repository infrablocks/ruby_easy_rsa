require 'lino'
require_relative 'base'

module RubyEasyRSA
  module Commands
    class BuildCA < Base
      def configure_command(builder, opts)
        pki_directory = opts[:pki_directory]
        algorithm = opts[:algorithm]
        digest = opts[:digest]
        key_size_in_bits = opts[:key_size_in_bits]
        expires_in_days = opts[:expires_in_days]
        distinguished_name_mode = opts[:distinguished_name_mode]
        common_name = opts[:common_name]
        country = opts[:country]
        province = opts[:province]
        city = opts[:city]
        organisation = opts[:organisation]
        organisational_unit = opts[:organisational_unit]
        email = opts[:email]
        batch = opts[:batch]
        encrypt_key = opts[:encrypt_key].nil? ? true : opts[:encrypt_key]
        sub_ca = opts[:sub_ca]

        builder = builder.with_option(
            '--pki-dir', pki_directory) if pki_directory
        builder = builder.with_option(
            '--use-algo', algorithm) if algorithm
        builder = builder.with_option(
            '--digest', digest) if digest
        builder = builder.with_option(
            '--days', expires_in_days) if expires_in_days
        builder = builder.with_option(
            '--keysize', key_size_in_bits) if key_size_in_bits
        builder = builder.with_option(
            '--dn-mode', distinguished_name_mode) if distinguished_name_mode
        builder = builder.with_option(
            '--req-cn', common_name, quoting: '"') if common_name
        builder = builder.with_option(
            '--req-c', country, quoting: '"') if country
        builder = builder.with_option(
            '--req-st', province, quoting: '"') if province
        builder = builder.with_option(
            '--req-city', city, quoting: '"') if city
        builder = builder.with_option(
            '--req-org', organisation, quoting: '"') if organisation
        builder = builder.with_option(
            '--req-ou', organisational_unit, quoting: '"') if organisational_unit
        builder = builder.with_option(
            '--req-email', email) if email
        builder = builder.with_flag(
            '--batch') if batch
        builder = builder.with_subcommand('build-ca')
        builder = builder.with_argument('nopass') unless encrypt_key
        builder = builder.with_argument('subca') if sub_ca
        builder
      end
    end
  end
end
