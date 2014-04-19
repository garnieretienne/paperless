class User < ActiveRecord::Base
  has_secure_password

  # Associations
  has_many :documents, dependent: :destroy
  has_many :labels, dependent: :destroy

  # Validations
  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :email, presence: true
  validates :email, uniqueness: true
  validates :password, presence: {on: :create}

  # Instance methods

  def full_name
    "#{first_name} #{last_name}"
  end

  def avatar_url
    gravatar_id = Digest::MD5.hexdigest(email.downcase)
    "http://gravatar.com/avatar/#{gravatar_id}.png?s=48"
  end
end
