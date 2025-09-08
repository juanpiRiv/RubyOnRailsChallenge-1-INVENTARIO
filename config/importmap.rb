# Pin npm packages by default by un-commenting the following in your package.json
# "dependencies": {
#   "@hotwired/turbo-rails": "^7.0.0",
#   "@hotwired/stimulus": "^3.0.0"
# }

pin "application", preload: true
pin "@hotwired/turbo-rails", to: "turbo.min.js", preload: true
pin "@hotwired/stimulus", to: "stimulus.min.js", preload: true
pin "@hotwired/stimulus-loading", to: "stimulus-loading.js", preload: true
pin_all_from "app/javascript/controllers", under: "controllers"
