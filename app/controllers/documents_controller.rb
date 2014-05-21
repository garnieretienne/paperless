class DocumentsController < ApplicationController

  def index
    @documents = paginate_documents current_user.documents
  end

  def create
    if params.require(:document)[:file].kind_of? Array
      params.require(:document)[:file].each do |file|
        document = current_user.documents.from_file(document_params.merge(file: file))
        document.save
      end
    else
      document = current_user.documents.from_file(document_params)
      document.save
    end
    respond_to do |format|
      format.js {render nothing: true}
    end
  end

  def open
    document = current_user.documents.find(params[:id])
    send_file document.file.url, disposition: :inline
  end

  def destroy
    document = current_user.documents.find(params[:id])
    document.destroy
    redirect_to :back
  end

  def search
    @query = params[:query]
    @documents = paginate_documents current_user.documents.search(@query)
  end

  def attach_label
    document = current_user.documents.find(params[:id])
    label = current_user.labels.find(params[:label_id])
    document.labels << label
    document.save
    respond_to do |format|
      format.js {render nothing: true}
    end
  end

  def detach_label
    document = current_user.documents.find(params[:id])
    label = current_user.labels.find(params[:label_id])
    document.labels.delete label
    document.save
    respond_to do |format|
      format.js {render nothing: true}
    end
  end

  private

  def document_params
    params.require(:document).permit(:file, label_ids: [])
  end
end
