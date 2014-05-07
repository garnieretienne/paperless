require 'test_helper'

class PDFUtilsTest < ActiveSupport::TestCase

  def setup
    @working_dir_path = Dir.mktmpdir
  end

  def teardown
    FileUtils.rm_r @working_dir_path
  end

  test "should convert an image into a PDF file" do
    image_path = fixture_file_path("image.jpg")
    pdf_path = "#{@working_dir_path}/image.pdf"
    assert Paperless::PDFUtils.convert_image_to_pdf image_path, pdf_path
    assert File.exist? pdf_path
  end
end
