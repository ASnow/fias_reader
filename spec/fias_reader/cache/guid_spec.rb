require 'spec_helper'

describe FiasReader::Cache::Guid do
  subject { described_class.new *init_from }

  TEST_GUID = '8755876c-3ba8-4454-a00b-f780fb646773'.freeze
  TEST_PARTS = [36_328_470_211, 16_014_132_554, 42_962_221_071, 4_217_661_299].freeze

  describe '.new' do
    shared_examples 'parts storage' do |arg|
      let(:init_from) { arg }
      let(:valid_parts) { TEST_PARTS.dup }
      it 'store valid parts' do
        expect(subject.parts).to eq(valid_parts)
      end
    end
    it_behaves_like 'parts storage', [TEST_GUID.dup]
    it_behaves_like 'parts storage', [TEST_PARTS.dup]
    it_behaves_like 'parts storage', TEST_PARTS.dup
    it_behaves_like 'parts storage', [{ pk0: 36_328_470_211, pk1: 16_014_132_554, pk2: 42_962_221_071, pk3: 4_217_661_299 }]
    it_behaves_like 'parts storage', [{ other0: 36_328_470_211, other1: 16_014_132_554, other2: 42_962_221_071, other3: 4_217_661_299 }]
    it_behaves_like 'parts storage', [{ a0: 36_328_470_211, a1: 16_014_132_554, a2: 42_962_221_071, a3: 4_217_661_299, b0: 0, b1: 0, b2: 0, b3: 0 }, :a]
  end

  describe '#to_attr' do
    let(:init_from) { TEST_PARTS.dup }
    it 'store valid parts' do
      expect(subject.to_attr(:id)).to eq('id0' => 36_328_470_211, 'id1' => 16_014_132_554, 'id2' => 42_962_221_071, 'id3' => 4_217_661_299)
    end
  end

  describe '#to_guid' do
    let(:init_from) { [TEST_GUID.dup] }
    it 'load and dump' do
      described_class.new(subject.to_attr(:id)).to_guid == init_from.first
    end
  end
end
