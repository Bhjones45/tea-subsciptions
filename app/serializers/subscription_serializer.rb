class SubscriptionSerializer
  include JSONAPI::Serializer

  set_type 'subscriptions'
  attributes :title, :price, :status, :frequency
end
