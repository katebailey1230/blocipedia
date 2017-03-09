class ChargesController < ApplicationController
    
after_action :upgrade_account, only: [:create]
after_action :downgrade_account, only: [:downgrade]    
    
def new
 end
    
def create

    @amount = 15_00

    customer = Stripe::Customer.create(
      :email => params[:stripeEmail],
      :source  => params[:stripeToken]
    )

    charge = Stripe::Charge.create(
      :customer    => customer.id,
      :amount      => 15_00,
      :description => 'Premium Account',
      :currency    => 'usd'
    )

      rescue Stripe::CardError => e
      flash[:error] = e.message
      redirect_to new_charge_path
   end

def downgrade

    @amount = -15_00

    customer = Stripe::Customer.change(
      :email => params[:stripeEmail],
      :source  => params[:stripeToken]
    )

    charge = Stripe::Charge.change(
      :customer    => customer.id,
      :amount      => -15_00,
      :description => 'Standard Account',
      :currency    => 'usd'
    )

      rescue Stripe::CardError => e
      flash[:notice] = "Your account been downgraded to standard."
    redirect_to edit_user_registration_path
   end    
     private

   def upgrade_account
       current_user.update_attribute(:role, 'premium')
   end
    
    def downgrade_account
       current_user.update_attribute(:role, 'standard')
   end
  end