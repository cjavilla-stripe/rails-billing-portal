class UsersController < ApplicationController
  def new
    if !params[:plan]
      redirect_to '/pricing'
    end
  end

  def create
    @user = User.new(user_params)
    if @user.save
      customer = create_stripe_customer(@user)
      @session = create_checkout_session(customer, @user)
      session[:token] = @user.session_token
      render :checkout
    else
      flash.now[:error] = @user.errors.full_messages
      render :new
    end
  end

  private

  def create_stripe_customer(user)
    customer = Stripe::Customer.create(
      email: @user.email,
      metadata: {
        selected_plan: @user.plan
      }
    )
    user.update!(stripe_customer_id: customer.id)
    customer
  end

  def create_checkout_session(customer, user)
    Stripe::Checkout::Session.create({
      customer: customer.id,
      success_url: 'http://localhost:3000/success',
      cancel_url: 'http://localhost:3000/cancel',
      payment_method_types: ['card'],
      subscription_data: {
        items: [{ plan: plans[user.plan] }],
      },
    })
  end

  def user_params
    params.require(:user).permit(:email, :password, :plan)
  end
end
