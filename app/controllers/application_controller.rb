class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  helper_method :current_user
  before_filter :authenticated!, except: [:login, :logout, :authenticate]
  before_filter :load_user_objects, except: [:login, :logout, :authenticate]

  private

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def load_user_objects
    load_user_labels
    create_new_document
    create_new_label
  end

  def create_new_document
    @new_document = current_user.documents.new
  end

  def create_new_label
    @new_label = current_user.labels.new
  end

  def load_user_labels
    @user_labels = current_user.labels
  end

  def authenticated!
    redirect_to login_path unless current_user
    return
  end

  def paginate_documents(documents)
    @page = params[:page]
    documents.paginate page: @page, per_page: 15
  end
end
