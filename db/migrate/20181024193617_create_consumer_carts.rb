class CreateConsumerCarts < ActiveRecord::Migration[5.0]
  def change
    create_table :consumer_carts do |t|

      t.timestamps
    end
  end
end
