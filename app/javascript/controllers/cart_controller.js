import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["display"]

  connect() {
    console.log("✅ CartController chargé")
    this.loadCart()
    this.displayCart()
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

    this.displayCart() // pour mettre à jour la vue si on est sur /carts/1
  }

  displayCart() {
    if (!this.hasDisplayTarget) return

    const savedCart = JSON.parse(localStorage.getItem("cart")) || []

    if (savedCart.length === 0) {
      this.displayTarget.innerHTML = "<p>Votre panier est vide.</p>"
      return
    }

    let total = 0
    const html = savedCart.map(item => {
      const subtotal = item.price * item.qty
      total += subtotal
      return `<div>
        <strong>${item.name}</strong> – ${item.qty} × ${item.price.toFixed(2)} € = ${subtotal.toFixed(2)} €
      </div>`
    }).join("")

    this.displayTarget.innerHTML = html + `<hr><strong>Total : ${total.toFixed(2)} €</strong>`
  }

  loadCart() {
    const savedCart = localStorage.getItem("cart")
    this.cart = savedCart ? JSON.parse(savedCart) : []
  }

  test() {
    console.log("✅ Stimulus fonctionne bien.")
  }
}
