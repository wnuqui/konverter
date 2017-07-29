require 'rails_helper'

RSpec.describe 'routes', type: :routing do
  describe 'GET /conversions?base=USD&target=EURO' do
    it 'routes' do
      expect(post: '/conversions?base=USD&target=EURO').to route_to(
        controller: 'conversions',
        action: 'create',
        base: 'USD',
        target: 'EURO'
      )
    end
  end
end
