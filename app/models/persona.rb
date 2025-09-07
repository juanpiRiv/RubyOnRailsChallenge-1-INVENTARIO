class Persona < ApplicationRecord
  has_many :articulos, foreign_key: :portador_id, dependent: :destroy
  has_many :transferencias_como_portador_anterior, class_name: "Transferencia", foreign_key: "portador_anterior_id", dependent: :destroy
  has_many :transferencias_como_nuevo_portador, class_name: "Transferencia", foreign_key: "nuevo_portador_id", dependent: :destroy

  validates :nombre, presence: true
  validates :apellido, presence: true

  def todas_las_transferencias
    Transferencia.where("portador_anterior_id = ? OR nuevo_portador_id = ?", id, id)
  end
end
