class CreateTransferencias < ActiveRecord::Migration[8.0]
  def change
    create_table :transferencias do |t|
      t.references :articulo, null: false, foreign_key: true
      t.references :persona, null: false, foreign_key: true
      t.date :fecha

      t.timestamps
    end
  end
end
