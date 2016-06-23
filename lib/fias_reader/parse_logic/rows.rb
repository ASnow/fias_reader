module FiasReader
  module ParseLogic
    module Rows
      include FiasReader::ParseLogic::Abstract

      def initialize(options)
        @rows_enabled = true if @options[:rows].respond_to? :call
        super
      end

      def start_element(name)
        if @rows_enabled && @depth == 2
          @row = {}
          @skip = false
        end
        super
      end

      def end_element(name)
        if @rows_enabled && @depth == 1
          @options[:rows].call(@row) if @row
          @row = nil
        end
        super
      end
    end
  end
end
