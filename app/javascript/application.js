import { Application } from "@hotwired/stimulus"
import CartController from "./controllers/cart_controller"
import HelloController from "./controllers/hello_controller"

window.Stimulus = Application.start()
Stimulus.register("cart", CartController)
Stimulus.register("hello", HelloController)