require 'spec_helper'

describe APICoder::Resource::Link do
  let(:link)      { described_class.new(namespace, name, options) }
  let(:namespace) { :TestClass }
  let(:name)      { :test_link }
  let(:options)   { Hash.new }

  describe '#request' do
    subject { link.request }

    before do
      link.request_options = request_options
      link.path = path
      link.method = method
    end

    let(:request_options) { { test: :link } }
    let(:path) { '/tests' }
    let(:method) { 'GET' }
    let(:arguments) { [namespace, name, request_options.merge(path: path, method: method)] }

    it 'should correct argument give to Request class' do
      expect(APICoder::Resource::Request).to receive(:new).with(*arguments)
      subject
    end
  end

  describe '#response' do
    subject { link.response }

    before do
      link.response_options = response_options
    end

    let(:response_options) { double('ResponseOptions') }
    let(:arguments) { [namespace, name, response_options] }

    it 'should correct argument give to Response class' do
      expect(APICoder::Resource::Response).to receive(:new).with(*arguments)
      subject
    end
  end
end
