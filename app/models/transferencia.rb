class Transferencia < ApplicationRecord
  belongs_to :articulo
  belongs_to :persona
end
