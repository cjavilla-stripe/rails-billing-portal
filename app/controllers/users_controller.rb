class UsersController < ApplicationController
  def new
    if !params[:plan]
      redirect_to '/pricing'
    end
  end

  def create

  end
end
