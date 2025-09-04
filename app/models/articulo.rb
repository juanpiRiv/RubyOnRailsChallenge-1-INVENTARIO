# app/models/articulo.rb
class Articulo < ApplicationRecord
  belongs_to :portador, class_name: "Persona"
  has_many :transferencias
end