import { application } from "../application"

import CartController from "./cart_controller"
application.register("cart", CartController)

import HelloController from "./hello_controller"
application.register("hello", HelloController)
