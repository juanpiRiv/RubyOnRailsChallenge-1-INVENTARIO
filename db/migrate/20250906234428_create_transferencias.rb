class CreateTransferencias < ActiveRecord::Migration[8.0]
  def change
    create_table :transferencias do |t|
      t.references :articulo, null: false, foreign_key: true
      t.references :portador_anterior, null: false, foreign_key: { to_table: :personas }
      t.references :nuevo_portador, null: false, foreign_key: { to_table: :personas }
      t.date :fecha

      t.timestamps
    end
  end
end
