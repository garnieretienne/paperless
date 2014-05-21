class Document < ActiveRecord::Base

  # Associations
  belongs_to :owner, class_name: "User", foreign_key: "user_id"
  has_and_belongs_to_many :labels, -> { uniq }

  # Attached files
  mount_uploader :file, DocumentUploader

  # Callbacks
  before_validation :convert_image_to_pdf, on: :create

  # Validations
  validates :owner, presence: true
  validates :title, presence: true
  validates :file, presence: true
  validates :labels, same_user_ids: true

  # Scopes
  default_scope { includes(:labels).order(created_at: :desc) }

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
      rank = "ts_rank(to_tsvector('simple', title), plainto_tsquery(#{sanitize(query)}))"
      search_query = "to_tsvector('simple', title) @@ :q OR "
      search_query += "to_tsvector('simple', title) @@ plainto_tsquery(:q)"
      where(search_query, q: query).order("#{rank} desc")
    else
      all
    end
  end

  # Instance methods

  private

  def convert_image_to_pdf
    uploaded_file = file.file
    if uploaded_file.present? && !uploaded_file.content_type.nil? && uploaded_file.content_type.start_with?("image/")
      image_path = file.current_path
      pdf_path = File.dirname(file.current_path) + "/" + File.basename(uploaded_file.file.sub(/\.[^\.]*$/, ".pdf"))
      if Paperless::PDFUtils.convert_image_to_pdf image_path, pdf_path
        self.file = File.new pdf_path
        true
      else
        errors[:file] = "cannot be converted imto a PDF file"
        false
      end
    end
  end
end
