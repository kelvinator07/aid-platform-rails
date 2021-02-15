class CreateFacts < ActiveRecord::Migration[6.0]
  def change
    create_table :facts do |t|
      t.string :body
      t.integer :likes

      t.timestamps
    end
  end
end
