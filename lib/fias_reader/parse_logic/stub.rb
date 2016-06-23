module FiasReader
  module ParseLogic
    module Stub
      include FiasReader::ParseLogic::Abstract

      def initialize(options)
      end

      def start_element(name)
      end

      def end_element(name)
      end

      def attr(name, value)
      end

      def text(value)
      end
    end
  end
end
