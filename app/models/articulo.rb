require "csv"

class Articulo < ApplicationRecord
  belongs_to :portador, class_name: "Persona"
  has_many :transferencias, dependent: :destroy

  validates :marca, presence: true
  validates :modelo, presence: true
  validates :fecha_ingreso, presence: true
  validates :portador, presence: true

  # Scopes para filtros
  scope :filter_by_marca, ->(marca) { where("marca LIKE ?", "%#{marca}%") }
  scope :filter_by_modelo, ->(modelo) { where("modelo LIKE ?", "%#{modelo}%") }
  scope :filter_by_fecha_desde, ->(fecha) { where("fecha_ingreso >= ?", fecha) }
  scope :filter_by_fecha_hasta, ->(fecha) { where("fecha_ingreso <= ?", fecha) }

  # Método para mostrar marca y modelo en los select
  def full_name
    "#{marca} #{modelo}"
  end

  def self.to_csv(scope = all)
    headers = %w[id modelo marca fecha_ingreso portador_id created_at updated_at]

    CSV.generate(headers: true) do |csv|
      csv << headers
      scope.each do |articulo|
        csv << [
          articulo.id,
          articulo.modelo,
          articulo.marca,
          articulo.fecha_ingreso,
          articulo.portador_id,
          articulo.created_at,
          articulo.updated_at
        ]
      end
    end
  end
end
