module Paperless

  class PDFUtils

    def self.convert_image_to_pdf(image_path, pdf_path)
      `convert #{image_path} #{pdf_path}`
      File.exist? pdf_path
    end
  end
end