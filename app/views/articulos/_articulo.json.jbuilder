json.extract! articulo, :id, :modelo, :marca, :fecha_ingreso, :portador_id, :created_at, :updated_at
json.url articulo_url(articulo, format: :json)
