require 'spec_helper'

describe FiasReader do
  it 'has a version number' do
    expect(FiasReader::VERSION).not_to be nil
  end

  describe '.open' do
    subject { described_class.open('test_file') }

    it 'returns Reader' do
      expect(subject).to be_instance_of(described_class::Reader)
      expect(subject.path).to eq('test_file')
    end
  end
end
