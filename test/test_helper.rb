ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'

class ActiveSupport::TestCase
  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
  #
  # Note: You'll currently still have to declare fixtures explicitly in integration tests
  # -- they do not yet inherit this setting
  fixtures :all

  # Add more helper methods to be used by all tests here...

  def fixture_file_path(filename)
    Rails.root.join('test', 'fixtures', 'files', filename).to_s
  end

  def authenticate_user(user)
    session[:user_id] = user.id
  end

  def deauthenticated_user
    session[:user_id] = nil
  end
end

# Override the default store dir to serve files from fixture path
class DocumentUploader < CarrierWave::Uploader::Base
  def store_dir
    Rails.root.join('test', 'fixtures', 'files').to_s
  end
end

