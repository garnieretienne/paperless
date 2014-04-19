class CreateLabels < ActiveRecord::Migration
  def change
    create_table :labels do |t|
      t.string :name
      t.references :user, index: true

      t.timestamps
    end
  end
end
