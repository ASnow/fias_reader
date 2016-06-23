require 'spec_helper'

describe FiasReader::Scope do
  let(:reader) { double :reader }
  let(:table) { FiasReader::Table.new reader }
  let(:test_file_path) { File.expand_path('../../support/files/scope.xml', __FILE__) }
  let(:test_file) { File.new(test_file_path, 'r') }

  subject { described_class.new table }

  before(:each) do
    allow(table).to receive(:file).and_return(test_file)
  end

  describe '.new' do
    it 'use table logics' do
      stub_const("#{table.class.name}::LOGICS", ['test'])
      expect(subject.logics).to eq(['test'])
    end
  end

  describe '#all' do
    it 'define row proc' do
      expect(FiasReader::Parser).to receive(:new).with(include(FiasReader::ParseLogic::Rows), hash_including(:rows))
      subject.all {}
    end

    it 'runs parse!' do
      expect(subject).to receive(:parse!).with(no_args)
      subject.all {}
    end
  end

  describe '#first' do
    it 'define row proc' do
      expect(FiasReader::Parser).to receive(:new).with(include(FiasReader::ParseLogic::Rows), hash_including(:rows))
      subject.first
    end

    it 'return hash' do
      expect(subject.first).to be_a(Hash)
    end

    it 'runs parse!' do
      expect(subject).to receive(:parse!).with(no_args)
      subject.first
    end
  end

  describe '#select' do
    it 'replace attributes select logic' do
      expect(subject.logics).to include(FiasReader::ParseLogic::Attributes)
      subject.select :a
      expect(subject.logics).to_not include(FiasReader::ParseLogic::Attributes)
      expect(subject.logics).to include(FiasReader::ParseLogic::AttributesSelect)
    end

    it 'set attributes to select' do
      subject.select :a, :b, :c
      expect(subject.options[:select]).to match_array([:a, :b, :c])
    end

    it 'chain calls' do
      expect(subject.select).to be(subject)
    end
  end

  describe '#parse!' do
    context 'stubbed' do
      it 'use default_parser by deafult' do
        expect(Ox).to receive(:sax_parse).with(be_a(FiasReader::Parser), test_file, symbolize: true)
        subject.parse!
      end

      it 'use argument parser' do
        new_parser = FiasReader::Parser.new([], {})
        expect(Ox).to receive(:sax_parse).with(new_parser, test_file, symbolize: true)
        subject.parse! new_parser
      end
    end
  end
end
