class Articulo < ApplicationRecord
  belongs_to :portador, class_name: "Persona"
  has_many :transferencias, dependent: :destroy

  validates :marca, presence: true
  validates :modelo, presence: true
  validates :fecha_ingreso, presence: true
  validates :portador, presence: true

  # Método para mostrar marca y modelo en los select
  def full_name
    "#{marca} #{modelo}"
  end
end
