require 'spec_helper'

describe FiasReader::Cache::AddressPart do
  subject { described_class.new }

  describe '.index' do
    it 'ignore not actual' do
      scope = double(:scope)
      expect(FiasReader::Table::AddressPart).to receive(:new).with(:reader).and_return(scope)
      expect(scope).to receive_message_chain(:query, :all).and_yield(LIVESTATUS: '0')
      expect(described_class).to_not receive(:create)
      described_class.index :reader
    end

    it 'create actual' do
      scope = double(:scope)
      expect(FiasReader::Table::AddressPart).to receive(:new).with(:reader).and_return(scope)
      expect(scope).to receive_message_chain(:query, :all).and_yield(LIVESTATUS: '1', AOGUID: '8755876c-3ba8-4454-a00b-f780fb646773', PARENTGUID: '8755876c-3ba8-4454-a00b-f780fb646773')
      expect(described_class).to receive(:create)
      described_class.index :reader
    end
  end

  describe '#parent_string' do
    it 'save parent_string_cache' do
      parent = FiasReader::Cache::AddressPart.new
      parent[:AOLEVEL] = 1
      parent[:SHORTNAME] = 'sn'
      parent[:OFFNAME] = 'on'
      subject[:AOLEVEL] = 2
      expect(subject).to receive(:parent0).and_return(true).at_least(1)
      expect(FiasReader::Cache::AddressPart).to receive(:first).and_return(parent)
      levels = subject.parent_string
      expect(levels.state).to eq(%w(sn on))
      expect(levels.autonomy).to eq([nil, nil])
    end

    it 'use parent_string_cache if exists' do
      subject[:AOLEVEL] = 2
      expect(FiasReader::Cache::AddressPart).to_not receive(:first)
      expect(subject).to receive(:levels_filled).and_return(true)
      expect(subject).to receive(:levels).and_return(1)
      expect(subject.parent_string).to eq(1)
    end
  end
end
