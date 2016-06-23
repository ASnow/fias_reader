module FiasReader
  module ParseLogic
    extend ActiveSupport::Concern
    attr_accessor :element_name, :attr_name, :attr_value, :text

    def self.build(logics)
      Class.new do
        include FiasReader::ParseLogic::Stub

        logics.reverse.each do |logic|
          include logic
        end

        include FiasReader::ParseLogic
      end
    end

    included do
      # define_callbacks :initialize, :start_element, :end_element, :attr, :text

      def initialize(options)
        @options = options.dup.freeze
        super
      end
    end

    def start_element(name)
      @element_name = name
      super
    end

    def end_element(name)
      @element_name = name
      super
    end

    def attr(name, value)
      @attr_name = name
      @attr_value = value
      super
    end

    def text(value)
      @text = value
      super
    end
  end
end
