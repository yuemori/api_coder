require 'spec_helper'

describe APICoder::Resource do
  let(:resource) { described_class.new }

  shared_examples_for 'register methods' do
    before do
      registees.each_with_index do |registee, idx|
        allow(registee).to receive(:name).and_return(idx)
      end
    end

    let(:registry) { resource.send("#{registee_name}_registry") }
    let(:registees) { Array.new(3) { |i| double("#{registee_name}#{i}") } }

    it 'should be all registered' do
      resource.send("#{registee_name}s=", registees)

      registees.each do |registee|
        expect(resource.send(registee_name, registee.name)).to eq registee
      end
    end
  end

  describe '#attributes' do
    let(:registee_name) { :attribute }

    it_behaves_like 'register methods'
  end

  describe '#structs' do
    let(:registee_name) { :struct }

    it_behaves_like 'register methods'
  end

  describe '#links' do
    let(:registee_name) { :link }

    it_behaves_like 'register methods'
  end
end
