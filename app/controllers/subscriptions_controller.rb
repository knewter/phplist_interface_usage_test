class SubscriptionsController < ApplicationController

  def index
    @lists            = Phplist.find(:all)
    if request.post? && params[:email]
      lists = @lists.select{|l| params[:list_ids].include?(l.id.to_s)} }
      phplist_user = PhplistUser.find(:all, :params => { :email => params[:email] }).first rescue nil
      if phplist_user.nil?
        phplist_user = PhplistUser.create(:email => params[:email], :htmlemail => 1, :modified => DateTime.now)
      end

      # There is no ID column on the subscriptions table. destroy wont work without it
      # NYI
      if( params[:commit] == 'Subscribe')
        PhplistSubscription.unsubscribe_all(phplist_user)
        lists.each do |list|
          PhplistSubscription.subscribe_to(phplist_user, list.id) rescue nil
        end
      elsif params[:commit] = "Unsubscribe"
        lists.each do |list|
          PhplistSubscription.unsubscribe_to(phplist_user, list.id)
        end
      end
      flash[:notice] = "Subscriptions updated"
      redirect_to '/' 
    end
  end
end
