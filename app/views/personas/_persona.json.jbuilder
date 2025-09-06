json.extract! persona, :id, :nombre, :apellido, :created_at, :updated_at
json.url persona_url(persona, format: :json)
