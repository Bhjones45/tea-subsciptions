class Api::V1::SubscriptionsController < ApplicationController
  def index
    customer = Customer.find(params[:customer_id])
    render json: SubscriptionSerializer.new(customer.subscriptions)
  end

  def create
    customer = Customer.find(params[:customer_id])
    tea = Tea.find(params[:tea_id])
    subscription = customer.subscriptions.create(subscription_params.merge(tea_id: tea.id))
    if subscription.save
      render json: SubscriptionSerializer.new(subscription) #201
    else
      render json: {:error => 'Record not found'}, status: 404
    end
  end

  def update
    subscription = Subscription.find(params[:id])
    subscription.update(update_sub_params)
    render json: SubscriptionSerializer.new(subscription)
  end

  private
  def subscription_params
    params.permit(:title, :price, :status, :frequency)
  end

  def update_sub_params
    params.permit(:status)
  end
end
