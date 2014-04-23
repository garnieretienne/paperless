class Label < ActiveRecord::Base

  # Associations
  belongs_to :user
  has_and_belongs_to_many :documents, -> { uniq }

  # Validations
  validates :name, presence: true
  validates :name, uniqueness: {scope: :user_id}
  validates :documents, same_user_ids: true

  # Scopes
  default_scope { order(name: :asc) }
end
