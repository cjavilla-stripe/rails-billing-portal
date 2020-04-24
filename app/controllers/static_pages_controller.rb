class StaticPagesController < ApplicationController
  def success
    if !logged_in?
      redirect_to '/session/new'
    else
      redirect_to '/episodes'
    end
  end

  def account
    portal = Stripe::BillingPortal::Session.create(
      customer: current_user.stripe_customer_id,
      return_url: 'http://localhost:3000/episodes'
    )
    redirect_to portal.url
  end
end
