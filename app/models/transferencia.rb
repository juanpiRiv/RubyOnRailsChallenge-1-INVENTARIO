class Transferencia < ApplicationRecord
  belongs_to :articulo
  belongs_to :portador_anterior, class_name: "Persona"
  belongs_to :nuevo_portador, class_name: "Persona"

  validates :articulo, presence: true
  validates :portador_anterior, presence: true
  validates :nuevo_portador, presence: true
  validates :fecha, presence: true
  validate :portador_anterior_no_es_nuevo_portador

  private

  def portador_anterior_no_es_nuevo_portador
    if portador_anterior == nuevo_portador
      errors.add(:nuevo_portador, "no puede ser el mismo que el portador anterior")
    end
  end
end
