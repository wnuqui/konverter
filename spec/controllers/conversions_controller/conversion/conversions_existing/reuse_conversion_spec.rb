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
    context 'conversion' do
      let(:conversion) { '1 US dollar = 0.8927 euros' }

      context 'conversions existing' do
        context 'conversions made for the last 59 seconds' do
          it 'reuse conversion' do
            allow(Conversion).to receive(:convert_via_google).and_return(conversion)

            expect {
              post :create, params: params
            }.to change(Conversion, :count).by(1)

            expect(JSON.parse(response.body)['conversion']).to eq(conversion)

            travel 59.seconds do
              expect {
                post :create, params: params
              }.to_not change(Conversion, :count)
            end

            expect(JSON.parse(response.body)['conversion']).to eq(conversion)
          end
        end
      end
    end
  end
end
