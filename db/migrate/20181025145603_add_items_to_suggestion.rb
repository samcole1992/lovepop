class AddItemsToSuggestion < ActiveRecord::Migration[5.0]
  enable_extension 'hstore' unless extension_enabled?('hstore')

  def change
    remove_column :suggestions, :list
    add_column :suggestions, :free_shipping, :json
    add_column :suggestions, :holiday, :json
    add_column :suggestions, :discount, :json
    add_column :suggestions, :card_pack, :json
  end
end
