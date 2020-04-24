class ApplicationController < ActionController::Base
  helper_method :current_user

  def plans
    {
      'starter' => 'price_H9W9xkxMbPTk3y',
      'pro' => 'price_H9W9RCs3owmpDv',
      'enterprise' => 'price_H9W9ppxyCE1e2y',
    }
  end

  def logged_in?
    !!current_user
  end

  def current_user
    @current_user ||= User.find_by(session_token: session[:token])
  end

  def require_login!
    if !logged_in?
      redirect_to new_session_path
    end
  end

  def require_subscription!
    if current_user.subscription_status == 'cancelled'
      redirect_to '/cancelled'
    end
  end
end
