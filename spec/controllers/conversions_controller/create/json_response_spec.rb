require 'rails_helper'

RSpec.describe ConversionsController, type: :controller do
  include ActiveSupport::Testing::TimeHelpers

  around(type: :http) do |example|
    VCR.use_cassette('conversion') do
      example.run
    end
  end

  let(:params) do
    { base: 'USD', target: 'EURO', format: :json  }
  end

  describe 'POST create' do
    context 'JSON response' do
      context 'html accept type' do
        it 'responds JSON content', type: :http do
          post :create, params: params.merge(format: :html)
          expect(response.content_type).to_not eq('text/html')
          expect(response.content_type).to eq('application/json')
        end
      end

      context 'json accept type' do
        it 'responds JSON content', type: :http do
          post :create, params: params.merge(format: :json)
          expect(response.content_type).to eq('application/json')
        end
      end

      context 'default accept type' do
        it 'responds JSON content', type: :http do
          post :create, params: params
          expect(response.content_type).to eq('application/json')
        end
      end
    end
  end
end
