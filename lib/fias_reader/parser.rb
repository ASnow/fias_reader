module FiasReader
  class Parser < ::Ox::Sax
    attr_reader :logics
    delegate :start_element, :end_element, :attr, :text, to: :logics

    def initialize(logics, options)
      @logics = ParseLogic.build(logics).new options
    end
  end
end
