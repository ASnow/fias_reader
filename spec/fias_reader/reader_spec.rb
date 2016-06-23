require 'spec_helper'
require 'benchmark'

describe FiasReader::Reader do
  let(:test_file) { db_file('AS_HOUSE') }

  subject { described_class.new db_path }

  describe '#each' do
    # TODO: сделать микро-базу для тестов
    # it 'get line' do
    #   catch :spec do
    #     subject.each do |row|
    #       puts row.street
    #       puts row.settlement
    #       puts row.postal_code
    #       p row
    #       throw :spec
    #     end
    #   end
    # end

    # context 'profiling' do
    #   it 'xml+sql' do
    #     puts(
    #       Benchmark.measure do
    #         subject.each do |row|
    #           row.levels
    #         end
    #       end
    #     )
    #   end
    # end
  end
end
