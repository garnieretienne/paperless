class Document < ActiveRecord::Base

  # Associations
  belongs_to :owner, class_name: "User", foreign_key: "user_id"

  # Attached files
  mount_uploader :file, DocumentUploader

  # Validations
  validates :owner, presence: true
  validates :title, presence: true
  validates :file, presence: true

  # Scopes
  default_scope { order(created_at: :desc) }

  # Class methods

  def self.from_file(params)
    if params[:file]
      filename = params[:file].respond_to?(:original_filename) ? params[:file].original_filename : File.basename(params[:file])
      title = File.basename(filename, File.extname(filename))
      Document.new(params.merge(title: title))
    else
      Document.new(params)
    end
  end

  def self.search(query)
    if query.present?
      rank = <<-RANK
        ts_rank(to_tsvector(title), plainto_tsquery(#{sanitize(query)}))
      RANK
      where("to_tsvector('simple', title) @@ :q", q: query).order("#{rank} desc")
    else
      all
    end
  end
end
