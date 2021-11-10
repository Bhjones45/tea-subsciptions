require 'rails_helper'

RSpec.describe 'Subscription requests' do
  before(:each) do
    @customer1 = create(:customer)
    @customer2 = create(:customer)
    @tea1 = create(:tea)
    @tea2 = create(:tea)
  end

  describe 'POST api/v1/customers/:id/subscriptions' do
    it 'customer can create a tea subscription' do
      sub_params = {
                    customer_id: @customer1.id,
                    tea_id: @tea1.id,
                    title: 'Super Tea',
                    price: 10.00,
                    status: 'active',
                    frequency: 'monthly'
                  }

      post "/api/v1/customers/#{@customer1.id}/subscriptions", params: sub_params
      subscription = JSON.parse(response.body, symbolize_names: true)

      expect(response).to be_successful
      expect(subscription).to have_key(:data)
      expect(subscription[:data]).to have_key(:type)
      expect(subscription[:data]).to have_key(:attributes)
      expected = {
                  :frequency=>"monthly",
                  :price=>10.0,
                  :status=>"active",
                  :title=>"Super Tea"
                }
      expect(subscription[:data][:attributes]).to eq(expected)
    end
  end
end
