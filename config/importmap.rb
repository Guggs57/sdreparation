pin "application", to: "application.js", preload: true
pin "@hotwired/turbo-rails", to: "turbo.min.js"
pin_all_from "app/javascript/controllers", under: "controllers"
pin "stimulus" # @3.2.2
