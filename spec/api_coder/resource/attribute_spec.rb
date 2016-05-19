require 'spec_helper'

describe APICoder::Resource::Attribute do
  let(:attribute) { described_class.new(namespace, name, type_name) }
  let(:namespace) { :TestClass }
  let(:name) { :test_attribute }
  let(:type_name) { :string }

  describe 'delegation' do
    subject { attribute }
    it { should delegate_method(:match?).to(:type) }
  end

  describe '#to_example' do
    subject { attribute.to_example }

    before do
      allow(attribute).to receive(:type).and_return(type)
      allow(type).to receive(:example).and_return(example)
    end

    let(:type) { double('Type') }
    let(:example) { double('Example') }

    it { is_expected.to eq name => example }
  end
end
