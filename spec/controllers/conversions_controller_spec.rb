require 'rails_helper'

RSpec.describe ConversionsController, type: :controller do
  describe 'POST create' do
    it 'has a 200 status code' do
      post :create, params: { base: 'USD', target: 'EURO'}
      expect(response.status).to eq(200)
    end

    context 'JSON response' do
      context 'html accept type' do
        it 'responds JSON content' do
          post :create, params: { base: 'USD', target: 'EURO', format: :html  }
          expect(response.content_type).to_not eq 'text/html'
          expect(response.content_type).to eq 'application/json'
        end
      end

      context 'json accept type' do
        it 'responds JSON content' do
          post :create, params: { base: 'USD', target: 'EURO', format: :json  }
          expect(response.content_type).to eq 'application/json'
        end
      end

      context 'default accept type' do
        it 'responds JSON content' do
          post :create, params: { base: 'USD', target: 'EURO'  }
          expect(response.content_type).to eq 'application/json'
        end
      end
    end
  end
end
