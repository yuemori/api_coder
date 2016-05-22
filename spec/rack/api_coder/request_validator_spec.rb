require 'spec_helper'

describe Rack::APICoder::RequestValidator, type: :request do
  include Rack::Test::Methods

  before do
    load File.expand_path '../../../fixtures/user.conf', __FILE__
  end

  let(:app) do
    Rack::Builder.new do
      use Rack::APICoder::RequestValidator
      run ->(_env) { [200, {}, ['Internal Server Error']] }
    end
  end

  describe '#call' do
    subject { app }

    let(:parsed_body) { JSON.parse(last_response.body).symbolize_keys }

    context 'when not found route given(GET)' do
      it 'should return status 404' do
        get '/not_found'
        expect(last_response.status).to eq 404
        expect(parsed_body).to match(
          id: 'not_found',
          message: be_a(String)
        )
      end
    end

    context 'when found route given(GET)' do
      it 'should return status 200' do
        get '/users'
        expect(last_response.status).to eq 200
      end
    end

    context 'when found route and content_type is not application/jsoon given(POST)' do
      let(:params) do
        {
          id: 1,
          name: 'name',
          created_at: '20160101',
          updated_at: '20160102'
        }.to_json
      end

      it 'should return status 400' do
        post '/users', params, 'CONTENT_TYPE' => 'application/x-www-form-urlencoded'
        expect(last_response.status).to eq 400
        expect(parsed_body).to match(
          id: 'invalid_content_type',
          message: be_a(String)
        )
      end
    end

    context 'when valid route, header, not valid parameter given' do
      let(:params) do
        {
          name: 1,
          password: 'password'
        }.to_json
      end

      it 'should return status 400' do
        post '/users', params, 'CONTENT_TYPE' => 'application/json'
        expect(last_response.status).to eq 400
        expect(parsed_body).to match(
          id: 'invalid_parameter',
          message: be_a(String)
        )
      end
    end

    context 'when valid route, header, parameter given' do
      let(:params) do
        {
          name: 'name',
          password: 'password'
        }.to_json
      end

      it 'should return status 200' do
        post '/users', params, 'CONTENT_TYPE' => 'application/json'
        expect(last_response.status).to eq 200
      end
    end
  end
end
