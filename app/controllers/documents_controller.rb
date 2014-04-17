class DocumentsController < ApplicationController

  def index
    @documents = current_user.documents
  end

  def create
    document = current_user.documents.from_file(document_params)
    document.save
    redirect_to documents_path
  end

  def open
    document = current_user.documents.find(params[:id])
    send_file document.file.url, disposition: :inline
  end

  def destroy
    document = current_user.documents.find(params[:id])
    document.destroy
    redirect_to documents_path
  end

  private

  def document_params
    params.require(:document).permit(:file)
  end
end
