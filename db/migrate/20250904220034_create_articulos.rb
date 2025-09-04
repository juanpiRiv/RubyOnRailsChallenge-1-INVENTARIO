class CreateArticulos < ActiveRecord::Migration[8.0]
  def change
    create_table :articulos do |t|
      t.string :marca
      t.string :modelo
      t.date :fecha_ingreso
      t.references :portador, foreign_key: { to_table: :personas }

      t.timestamps
    end
  end
end

