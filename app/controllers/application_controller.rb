class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def current_user
    User.first
  end
  helper_method :current_user

  def create_new_document
    @new_document = current_user.documents.new
  end
  before_filter :create_new_document
end
