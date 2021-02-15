class CreateRequests < ActiveRecord::Migration[6.0]
  def change
    create_table :requests do |t|
      t.string :description
      t.float :lat
      t.float :lng
      t.boolean :fulfilled, default: false
      t.integer :fulfilcount, default: 0

      t.timestamps
    end
  end
end
