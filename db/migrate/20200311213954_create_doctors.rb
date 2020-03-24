class CreateDoctors < ActiveRecord::Migration[6.0]
  def change
    create_table :doctors do |t|
      t.string :first_name
      t.string :last_name
      t.string :created_by
      t.string :updated_by

      t.timestamps
    end
  end
end
