# app/models/persona.rb
class Persona < ApplicationRecord
  has_many :articulos, foreign_key: :portador_id
  has_many :transferencias
end