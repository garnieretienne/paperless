class CreateDocumentsLabels < ActiveRecord::Migration
  def change
    create_table :documents_labels, id: false do |t|
      t.references :document, index: true
      t.references :label, index: true
    end
  end
end
