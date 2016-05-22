require 'spec_helper'

describe Rack::APICoder::Mock, type: :request do
  include Rack::Test::Methods

  before do
    load File.expand_path '../../../fixtures/user.conf', __FILE__
  end

  let(:app) do
    Rack::Builder.new do
      use Rack::APICoder::Mock
      run ->(_env) { [500, {}, ['Internal Server Error']] }
    end
  end

  describe '#call' do
    subject { app }

    before do
      allow_any_instance_of(APICoder::Type::Integer).to receive(:example).and_return(1)
      allow_any_instance_of(APICoder::Type::String).to receive(:example).and_return('test')
    end

    it 'should return example json' do
      get '/users'
      expect(last_response.status).to eq 200
      json = JSON.parse(last_response.body).symbolize_keys

      expect(json).to match(
        id: 1,
        name: 'test',
        created_at: 'test',
        updated_at: 'test'
      )
    end
  end
end
