class StaticPagesController < ApplicationController
  def success
    if !logged_in?
      redirect_to '/session/new'
    else
      redirect_to '/episodes'
    end
  end
end
