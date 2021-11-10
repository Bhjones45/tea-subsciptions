class Api::V1::SubscriptionsController < ApplicationController
  def create
    customer = Customer.find(params[:customer_id])
    tea = Tea.find(params[:tea_id])
    subscription = customer.subscriptions.create!(subscription_params.merge(tea_id: tea.id))
    if subscription.save
      render json: SubscriptionSerializer.new(subscription)
    else
      render json: {:error => 'Record not found'}, status: 404
    end
  end

  private
  def subscription_params
    params.permit(:title, :price, :status, :frequency)
  end
end
