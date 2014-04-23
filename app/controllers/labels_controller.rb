class LabelsController < ApplicationController

  def show
    @label = current_user.labels.find(params[:id])
    @documents = paginate_documents @label.documents
  end

  def create
    @label = current_user.labels.new(label_params)
    @label.save
    redirect_to :back
  end

  private

  def label_params
    params.require(:label).permit(:name)
  end
end
