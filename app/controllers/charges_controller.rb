class ChargesController < ApplicationController
    def new
        if current_user.premium?
            flash[:message] = 'You are already a premium user.'
            redirect_to root_path
        end
    end

    def create
        @amount = 1_500

        customer = Stripe::Customer.create(
            email: params[:stripeEmail],
            source: params[:stripeToken]
        )

        charge = Stripe::Charge.create(
            customer: customer.id,
            amount: 1_500,
            description: 'Premium Account',
            currency: 'usd'
        )
        current_user.premium!

        flash[:notice] = "Thanks for all the money, #{current_user.email}! Your account has been upgraded to premium."
        redirect_to edit_user_registration_path

    rescue Stripe::CardError => e
        flash[:error] = e.message
        redirect_to new_charge_path
    end

    def downgrade
        @amount = -1_500

        current_user.standard!

        flash[:notice] = 'Your account been downgraded to standard.'
        redirect_to edit_user_registration_path

    rescue Stripe::CardError => e
        flash[:error] = e.message
        redirect_to download_path
    end

    private

    def charges_params
        params.require(:charges).permit(:stripeToken, :amount)
    end
end
