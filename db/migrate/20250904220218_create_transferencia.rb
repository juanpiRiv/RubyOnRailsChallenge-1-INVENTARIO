class CreateTransferencia < ActiveRecord::Migration[8.0]
  def change
    create_table :transferencia do |t|
      t.references :articulo, null: false, foreign_key: true
      t.references :persona, null: false, foreign_key: true
      t.date :fecha

      t.timestamps
    end
  end
end
