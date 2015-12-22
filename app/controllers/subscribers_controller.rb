class SubscribersController < ApplicationController
  before_filter :authenticate_user!

  def new
  end

  def update
    token = params[:stripeToken]

    customer = Stripe::Customer.create(
      card: token,
      plan: 1234,
      email: current_user.email
    )

    current_user.subscribed = true
    current_user.stripe_id = customer.id
    current_user.update_attribute(:role, 'premium')
    current_user.save

    redirect_to root_path

    rescue Stripe::CardError => e
      flash[:error] = e.message
      redirect_to new_charge_path
  end

  def downgrade
    current_user.standard!
  end


end
