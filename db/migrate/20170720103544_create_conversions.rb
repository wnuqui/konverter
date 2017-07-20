class CreateConversions < ActiveRecord::Migration[5.1]
  def change
    create_table :conversions do |t|
      t.string :base
      t.string :target

      t.timestamps
    end
  end
end
