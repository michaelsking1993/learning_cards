class ApplicationController < ActionController::Base

  protected

  def authenticate_user!
    if user_signed_in?
      super
    else
      redirect_to root_path, notice: 'You must first sign in to visit this page!'
    end
  end
end
