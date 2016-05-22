require 'spec_helper'

describe APICoder::Type do
  describe 'default types' do
    %w(integer string float).each do |name|
      subject { described_class.fetch(name) }

      let(:klass) { "APICoder::Type::#{name.camelize}".constantize }

      it "#{name} is registered" do
        is_expected.to eq klass
      end
    end
  end
end

shared_examples_for 'type match' do
  context 'when match value given' do
    subject { described_class.new.valid?(valid_value) }

    it { is_expected.to be_truthy }
  end

  context 'when not match value given' do
    subject { described_class.new.valid?(invalid_value) }

    it { is_expected.to be_falsey }
  end
end

describe APICoder::Type::Value do
  describe '#valid?' do
    subject { described_class.new.valid?(value) }

    let(:value) { nil }

    it { is_expected.to be_truthy }
  end
end

describe APICoder::Type::String do
  describe '#valid?' do
    let(:valid_value) { '0' }
    let(:invalid_value) { 0 }

    it_behaves_like 'type match'
  end
end

describe APICoder::Type::Integer do
  describe '#valid?' do
    let(:valid_value) { 0 }
    let(:invalid_value) { '0' }

    it_behaves_like 'type match'
  end
end

describe APICoder::Type::Float do
  describe '#valid?' do
    let(:valid_value) { 0.1 }
    let(:invalid_value) { '0.1' }

    it_behaves_like 'type match'
  end
end
