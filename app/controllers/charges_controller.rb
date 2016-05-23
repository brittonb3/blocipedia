class ChargesController < ApplicationController
  def new
   @stripe_btn_data = {
     key: "#{ Rails.configuration.stripe[:publishable_key] }",
     description: "BigMoney Membership - #{current_user}",
     amount: 15_00
   }
 end

  def create
   customer = Stripe::Customer.create(
     email: current_user.email,
     card: params[:stripeToken]
   )

   charge = Stripe::Charge.create(
     customer: customer.id,
     amount: 15_00,
     description: "BigMoney Membership - #{current_user.email}",
     currency: 'usd'
   )
   current_user.premium!
   flash[:notice] = "#{current_user.email} you have been upgraded to Premium!"
   redirect_to root_path

   rescue Stripe::CardError => e
     flash[:alert] = e.message
     redirect_to new_charge_path
  end

  def downgrade
    current_user.standard!
    flash[:notice] = "#{current_user.email} you have been downgraded to Standard."
    redirect_to root_path
  end
end
