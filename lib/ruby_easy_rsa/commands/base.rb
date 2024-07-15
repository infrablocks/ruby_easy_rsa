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
        nil
      end

      def stdout
        $stdout
      end

      def stderr
        $stderr
      end

      def execute(parameters = {})
        parameters = resolve_parameters(parameters)

        do_before(parameters)
        result = build_and_execute_command(parameters)
        do_after(parameters)

        result
      end

      private

      def build_and_execute_command(parameters)
        command = configure_command(instantiate_builder, parameters).build

        command.execute(stdin:, stdout:, stderr:)
      end

      def instantiate_builder
        Lino::CommandLineBuilder
          .for_command(binary)
          .with_option_separator('=')
      end

      def do_before(_); end

      def configure_command(builder, _parameters)
        builder
      end

      def do_after(_); end

      def resolve_parameters(parameters)
        parameter_defaults(parameters)
          .merge(parameters)
          .merge(parameter_overrides(parameters))
      end

      def parameter_defaults(_parameters)
        {}
      end

      def parameter_overrides(_parameters)
        {}
      end
    end
  end
end
