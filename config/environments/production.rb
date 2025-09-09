require "active_support/core_ext/integer/time"

Rails.application.configure do
  # -----------------------
  # Configuración de producción
  # -----------------------

  # Código cargado al inicio para mejor performance
  config.eager_load = true
  config.enable_reloading = false

  # Reportes de errores deshabilitados en producción
  config.consider_all_requests_local = false

  # Caché de fragmentos y assets
  config.action_controller.perform_caching = true
  config.public_file_server.headers = { "cache-control" => "public, max-age=#{1.year.to_i}" }

  # Archivos subidos
  config.active_storage.service = :local

  # SSL
  config.assume_ssl = true
  config.force_ssl = true

  # Logging
  config.log_tags = [:request_id]
  config.logger = ActiveSupport::TaggedLogging.logger(STDOUT)
  config.log_level = ENV.fetch("RAILS_LOG_LEVEL", "info")
  config.active_support.report_deprecations = false

  # I18n
  config.i18n.fallbacks = true

  # Active Record
  config.active_record.dump_schema_after_migration = false
  config.active_record.attributes_for_inspect = [:id]

  # -----------------------
  # Host Authorization para Railway
  # -----------------------
  # Limpiar lista de hosts y permitir cualquier subdominio de railway
  config.hosts.clear
  config.hosts << /[a-z0-9\-]+\.up\.railway\.app/

end
