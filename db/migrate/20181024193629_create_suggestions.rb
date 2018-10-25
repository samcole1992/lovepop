class CreateSuggestions < ActiveRecord::Migration[5.0]
  def change
    create_table :suggestions do |t|
      t.string :list, array: true, default: []
      t.timestamps
    end
  end
end
