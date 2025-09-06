class Persona < ApplicationRecord
  has_many :articulos, foreign_key: :portador_id, dependent: :destroy
  has_many :transferencias, dependent: :destroy
end
