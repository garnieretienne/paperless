class UsersController < ApplicationController
  def login
    render layout: "login"
  end

  def authenticate
    @email = params[:email]
    user = User.find_by(email: @email).try(:authenticate, params[:password])
    if user
      session[:user_id] = user.id
      redirect_to documents_path
    else
      render :login, layout: "login"
    end
  end

  def logout
    session[:user_id] = nil
    redirect_to root_url
  end
end
