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

  class Configuration
    attr_accessor :binary

    def initialize
      @binary = 'easyrsa'
    end
  end
end
