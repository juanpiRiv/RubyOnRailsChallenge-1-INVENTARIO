class CreateTransferencia < ActiveRecord::Migration[8.0]
  def change
    create_table :transferencia do |t|
      t.timestamps
    end
  end
end
