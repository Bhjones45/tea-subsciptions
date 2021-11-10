require 'rails_helper'

RSpec.describe 'Subscription requests' do
  before(:each) do
    @customer1 = create(:customer)
    @customer2 = create(:customer)
    @tea1 = create(:tea)
    @tea2 = create(:tea)
  end

  describe 'POST /api/v1/customers/:id/subscriptions' do
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

  describe 'PATCH /api/v1/customers/:id/subscriptions' do
    it 'can change subscription status' do
      sub_params = {
                    customer_id: @customer1.id,
                    tea_id: @tea1.id,
                    title: 'Super Tea',
                    price: 10.00,
                    status: 'active',
                    frequency: 'monthly'
                  }
      subscription = Subscription.create(sub_params)
      patch "/api/v1/customers/#{@customer1.id}/subscriptions/#{subscription.id}", params: { status: 'inactive' }

      expect(response).to be_successful
      new_status = JSON.parse(response.body, symbolize_names: true)
      expect(new_status).to have_key(:data)
      expect(new_status[:data]).to have_key(:type)
      expect(new_status[:data]).to have_key(:attributes)
      expected = {
        title: 'Super Tea',
        price: 10.00,
        status: 'inactive',
        frequency: 'monthly'
      }
      expect(new_status[:data][:attributes]).to eq(expected)
      expect(new_status[:data][:attributes][:status]).to eq('inactive')
    end
  end

  describe 'sad path' do
    xit 'can render 404 error when no tea is found' do
      sub_params = {
                    customer_id: @customer1.id,
                    tea_id: @tea2.id,
                    title: 'Super Tea',
                    price: 10.00,
                    status: 'active',
                    frequency: 'monthly'
                  }
     post "/api/v1/customers/#{@customer1.id}/subscriptions", params: sub_params
     expect(response.status).to eq(404)
    end
  end
end
