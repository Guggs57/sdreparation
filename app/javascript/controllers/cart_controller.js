import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  connect() {
    console.log("✅ CartController chargé")
    this.loadCart()
  }

  add(event) {
    console.log("🖱️ Bouton cliqué !")

    const button = event.currentTarget
    const id = button.dataset.id
    const name = button.dataset.name
    const price = parseFloat(button.dataset.price)

    const item = { id, name, price, qty: 1 }

    const cart = this.cart || []
    const existingItem = cart.find((i) => i.id === id)

    if (existingItem) {
      existingItem.qty += 1
    } else {
      cart.push(item)
    }

    this.cart = cart
    localStorage.setItem("cart", JSON.stringify(cart))
    console.log("🛒 Panier mis à jour :", cart)
  }

  test() {
    console.log("✅ Stimulus fonctionne bien.")
  }

  loadCart() {
    const savedCart = localStorage.getItem("cart")
    this.cart = savedCart ? JSON.parse(savedCart) : []
  }

  
}
