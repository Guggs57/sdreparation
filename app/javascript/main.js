import { Application } from "@hotwired/stimulus"
import "@hotwired/turbo-rails"
import CartController from "controllers/cart_controller" // <-- grâce au pin

const application = Application.start()
window.Stimulus = application
application.register("cart", CartController)
