class PhplistSubscription < ActiveResource::Base
  self.site = AR_SERVER

  def self.unsubscribe_all user
    get :unsubscribe_user, :email => user.email
  end

  def self.subscribe_to user, list_id
    get :subscribe_user, :email => user.email, :list_id => list_id
  end

  def self.unsubscribe_to user, list_id
    get :unsubscribe_user, :email => user.email, :list_id => list_id
  end
end
