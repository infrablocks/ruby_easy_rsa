require 'ruby_easy_rsa/version'
require 'ruby_easy_rsa/commands'

module RubyEasyRSA
  class << self
    attr_writer :configuration

    def configuration
      @configuration ||= Configuration.new
    end

    def configure
      yield(configuration)
    end

    def reset!
      @configuration = nil
    end
  end

  module ClassMethods
    def init_pki(opts = {})
      Commands::InitPKI.new.execute(opts)
    end

    def build_ca(opts = {})
      Commands::BuildCA.new.execute(opts)
    end

    def gen_dh(opts = {})
      Commands::GenDH.new.execute(opts)
    end

    def gen_req(opts = {})
      Commands::GenReq.new.execute(opts)
    end

    def sign_req(opts = {})
      Commands::SignReq.new.execute(opts)
    end

    def build_client_full(opts = {})
      Commands::BuildClientFull.new.execute(opts)
    end

    def build_server_full(opts = {})
      Commands::BuildServerFull.new.execute(opts)
    end

    def revoke(opts = {})
      Commands::Revoke.new.execute(opts)
    end

    def gen_crl(opts = {})
      Commands::GenCRL.new.execute(opts)
    end

    def update_db(opts = {})
      Commands::UpdateDB.new.execute(opts)
    end

    def show_req(opts = {})
      Commands::ShowReq.new.execute(opts)
    end

    def show_cert(opts = {})
      Commands::ShowCert.new.execute(opts)
    end

    def import_req(opts = {})
      Commands::ImportReq.new.execute(opts)
    end

    def export_p7(opts = {})
      Commands::ExportP7.new.execute(opts)
    end

    def export_p12(opts = {})
      Commands::ExportP12.new.execute(opts)
    end

    def set_rsa_pass(opts = {})
      Commands::SetRSAPass.new.execute(opts)
    end

    def set_ec_pass(opts = {})
      Commands::SetECPass.new.execute(opts)
    end
  end
  extend ClassMethods

  def self.included(other)
    other.extend(ClassMethods)
  end

  class Configuration
    attr_accessor :binary

    def initialize
      @binary = 'easyrsa'
    end
  end
end
