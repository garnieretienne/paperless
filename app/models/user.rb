class User < ActiveRecord::Base

  # Associations
  has_many :documents

  # Validations
  validates :first_name, presence: true
  validates :last_name, presence: true

  # Instance methods
  def full_name
    "#{first_name} #{last_name}"
  end
end
