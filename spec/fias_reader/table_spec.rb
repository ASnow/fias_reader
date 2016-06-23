require 'spec_helper'

describe FiasReader::Table do
  let(:files_dir) { ::File.expand_path('../../support/files/', __FILE__) }
  let(:reader) { double :reader, path: files_dir }

  subject { described_class.new reader }

  it 'has LOGICS array' do
    expect(described_class::LOGICS).to be_an(Array)
    expect(described_class::LOGICS).to all(be <= FiasReader::ParseLogic::Abstract)
    expect(described_class::LOGICS).to include(FiasReader::ParseLogic::Rows)
    expect(described_class::LOGICS).to include(FiasReader::ParseLogic::Depth)
    expect(described_class::LOGICS).to include(FiasReader::ParseLogic::Attributes)
  end

  describe '#initialize' do
    let(:reader) { 'test' }
    it 'store first argument to @reader ' do
      expect(subject.instance_variable_get('@reader')).to eq('test')
    end
  end

  describe '#query' do
    it 'return scope' do
      expect(subject.query).to be_a(FiasReader::Scope)
    end
  end

  context 'inherits' do
    let(:subclass_filename) { 'TABLE1' }
    let(:subclass) { Class.new(described_class).tap { |a| a.const_set(:File, subclass_filename) } }
    subject { subclass.new reader }

    describe '#file' do
      it 'return file' do
        expect(subject.file).to be_a(::File)
      end

      it 'permission read' do
        expect(subject.file.read).to eq("table file content\n")
      end
    end

    describe '#file_path' do
      shared_examples 'mask search' do |ext|
        it 'return file path' do
          expect(subject.file_path).to eq("#{files_dir}/#{subclass_filename}_ommit_part.#{ext}")
        end
      end

      it_behaves_like 'mask search', :xml

      it_behaves_like 'mask search', :XML do
        let(:subclass_filename) { 'TABLE2_CAPS' }
      end
    end
  end
end
