class Label < ActiveRecord::Base

  # Associations
  belongs_to :user

  # Validations
  validates :name, presence: true
  validates :name, uniqueness: {scope: :user_id}

  # Scopes
  default_scope { order(name: :asc) }
end
