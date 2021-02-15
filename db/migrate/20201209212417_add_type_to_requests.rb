class AddTypeToRequests < ActiveRecord::Migration[6.0]
  def up
    execute <<-SQL
      CREATE TYPE type AS ENUM ('one_time', 'material_need');
    SQL

    add_column :requests, :type, :type, index: true
  end

  def down
    remove_column :requests, :type

    execute <<-SQL
      DROP TYPE type;
    SQL
  end
end
