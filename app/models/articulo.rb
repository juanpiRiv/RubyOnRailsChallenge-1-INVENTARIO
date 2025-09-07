class Articulo < ApplicationRecord
  belongs_to :portador, class_name: "Persona"
  has_many :transferencias, dependent: :destroy

  # Método para mostrar marca y modelo en los select
  def full_name
    "#{marca} #{modelo}"
  end
end