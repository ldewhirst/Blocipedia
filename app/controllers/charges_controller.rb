class ChargesController < ApplicationController

  def new
    @stripe_btn_data = {
      key: "#{ Rails.configuration.stripe[:publishable_key] }",
      description: "BigMoney Membership - #{current_user.email}",
      amount: 1499
    }
  end

  def create
    @amount = 1499

    #Creates a stripe customer object, for associating with the ChargesController
    customer = Stripe::Customer.create(
    email: current_user.email,
    card: params[:stripeToken]
    )

    charge = Stripe::Charge.create(
      customer: customer.id, #NOT the user_id
      amount: @amount,
      description: "BigMoney Membership - #{current_user.email}",
      currency: 'usd'
    )

    current_user.update_attribute(:role, 'premium')

    flash[:notice] = "Thanks for all the money, #{current_user.email}! Feel free to pay me again."
    redirect_to root_path(current_user)

    rescue Stripe::CardError => e
      flash[:error] = e.message
      redirect_to new_charge_path
  end

<<<<<<< HEAD
  def downgrade
    current_user.standard!
  end
=======

    def downgrade
      current_user.standard!
      current_user.save
      flash[:alert] = "Note: all private wikis you've created will become public upon downgrade"
      @wikis.user.private? == @wiki.public!
    end

>>>>>>> 7-upgrade
end
