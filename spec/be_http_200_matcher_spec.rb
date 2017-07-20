require_relative 'be_http_200_matcher'

RSpec.describe 'be_http_200 matcher' do
  it "passes when status is 200" do
    response = double(:response, status: 200)
    expect(response).to be_http_200
  end

  it "fails when status is 201" do
    response = double(:response, status: 201)
    expect(response).to_not be_http_200
  end
end
