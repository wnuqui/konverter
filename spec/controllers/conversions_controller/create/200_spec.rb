require 'rails_helper'

RSpec.describe ConversionsController, type: :controller do
  around(type: :http) do |example|
    VCR.use_cassette('conversion') do
      example.run
    end
  end

  let(:params) do
    { base: 'USD', target: 'EURO', format: :json  }
  end

  describe 'POST create' do
    it 'has a 200 status code', type: :http do
      post :create, params: params
      expect(response.status).to eq(200)
    end
  end
end
