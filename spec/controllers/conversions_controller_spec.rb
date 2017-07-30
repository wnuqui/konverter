require 'rails_helper'

RSpec.describe ConversionsController, type: :controller do
  include ActiveSupport::Testing::TimeHelpers

  let(:params) do
    { base: 'USD', target: 'EURO', format: :json  }
  end

  describe 'POST create' do
    it 'has a 200 status code' do
      post :create, params: params
      expect(response).to be_http_200
    end

    context 'JSON response' do
      context 'html accept type' do
        it 'responds JSON content' do
          post :create, params: { base: 'USD', target: 'EURO', format: :html  }
          expect(response.content_type).to_not eq('text/html')
          expect(response.content_type).to eq('application/json')
        end
      end

      context 'json accept type' do
        it 'responds JSON content' do
          post :create, params: params
          expect(response.content_type).to eq('application/json')
        end
      end

      context 'default accept type' do
        it 'responds JSON content' do
          post :create, params: { base: 'USD', target: 'EURO'  }
          expect(response.content_type).to eq('application/json')
        end
      end
    end

    context 'conversion' do
      let(:conversion) { '1 US dollar = 0.8927 euros' }

      context 'no conversions yet' do
        it 'creates a conversion' do
          allow(Conversion).to receive(:convert_via_google).and_return(conversion)

          expect {
            post :create, params: params
          }.to change(Conversion, :count).by(1)

          expect(JSON.parse(response.body)['conversion']).to eq(conversion)
        end
      end

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

        context 'conversions made for the last 61 seconds' do
          it 'creates new conversion' do
            allow(Conversion).to receive(:convert_via_google).and_return(conversion)

            expect {
              post :create, params: params
            }.to change(Conversion, :count).by(1)

            expect(JSON.parse(response.body)['conversion']).to eq(conversion)

            travel 61.seconds do
              expect {
                post :create, params: params
              }.to change(Conversion, :count).by(1)
            end

            expect(JSON.parse(response.body)['conversion']).to eq(conversion)
          end
        end
      end
    end
  end
end
