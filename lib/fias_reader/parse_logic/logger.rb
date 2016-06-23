module FiasReader
  module ParseLogic
    module Logger
      include FiasReader::ParseLogic::Abstract

      def start_element(name)
        puts "start: #{name}"
        super
      end

      def end_element(name)
        puts "end: #{name}"
        super
      end

      def attr(name, value)
        puts "  #{name} => #{value}"
        super
      end

      def text(value)
        puts "text #{value}"
        super
      end
    end
  end
end
