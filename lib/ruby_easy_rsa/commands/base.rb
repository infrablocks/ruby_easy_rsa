# frozen_string_literal: true

require 'lino'

module RubyEasyRSA
  module Commands
    class Base
      attr_reader :binary

      def initialize(binary: nil)
        @binary = binary || RubyEasyRSA.configuration.binary
      end

      def stdin
        ''
      end

      def stdout
        $stdout
      end

      def stderr
        $stderr
      end

      def execute(opts = {})
        do_before(opts)
        configure_command(instantiate_builder, opts)
          .build
          .execute(
            stdin: stdin,
            stdout: stdout,
            stderr: stderr
          )
        do_after(opts)
      end

      def instantiate_builder
        Lino::CommandLineBuilder
          .for_command(binary)
          .with_option_separator('=')
      end

      def do_before(_); end

      def configure_command(builder, _opts)
        builder
      end

      def do_after(_); end
    end
  end
end
