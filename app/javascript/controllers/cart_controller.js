import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = [
    "display", "firstName", "lastName", "email", "phone",
    "addressNumber", "addressStreet", "postalCode", "city"
  ]

  connect() {
    console.log("✅ CartController chargé")
    this.loadCart()
    this.displayCart()
  }

  loadCart() {
    const savedCart = localStorage.getItem("cart")
    this.cart = savedCart ? JSON.parse(savedCart) : []
  }

  add(event) {
    const button = event.currentTarget
    const id = button.dataset.id
    const name = button.dataset.name
    const price = parseFloat(button.dataset.price)

    const item = { id, name, price, qty: 1 }
    const existingItem = this.cart.find(i => i.id === id)

    if (existingItem) {
      existingItem.qty += 1
    } else {
      this.cart.push(item)
    }

    localStorage.setItem("cart", JSON.stringify(this.cart))
    console.log("🛒 Panier mis à jour :", this.cart)

    this.displayCart()
  }

  displayCart() {
    if (!this.hasDisplayTarget) return

    if (this.cart.length === 0) {
      this.displayTarget.innerHTML = "<p>Votre panier est vide.</p>"
      return
    }

    let total = 0
    const html = this.cart.map(item => {
      const subtotal = item.price * item.qty
      total += subtotal
      return `<div>
        <strong>${item.name}</strong> – ${item.qty} × ${item.price.toFixed(2)} € = ${subtotal.toFixed(2)} €
      </div>`
    }).join("")

    this.displayTarget.innerHTML = html + `<hr><strong>Total : ${total.toFixed(2)} €</strong>`
  }

  checkout() {
    console.log("🟡 checkout() déclenchée")

    if (this.cart.length === 0) {
      alert("Votre panier est vide.")
      return
    }

    // Validation simple des champs requis
    if (
      !this.firstNameTarget.value.trim() ||
      !this.lastNameTarget.value.trim() ||
      !this.emailTarget.value.trim() ||
      !this.addressNumberTarget.value.trim() ||
      !this.addressStreetTarget.value.trim() ||
      !this.postalCodeTarget.value.trim() ||
      !this.cityTarget.value.trim()
    ) {
      alert("Veuillez remplir tous les champs obligatoires.")
      return
    }

    const payload = {
      first_name: this.firstNameTarget.value,
      last_name: this.lastNameTarget.value,
      email: this.emailTarget.value,
      phone: this.phoneTarget.value,
      address_number: this.addressNumberTarget.value,
      address_street: this.addressStreetTarget.value,
      postal_code: this.postalCodeTarget.value,
      city: this.cityTarget.value,
      cart_data: this.cart
    }

    fetch("/checkout", {
      method: "POST",
      headers: { "Content-Type": "application/json", "Accept": "application/json" },
      body: JSON.stringify(payload)
    })
      .then(res => res.json())
      .then(data => {
        if (data.url) {
          console.log("🔁 Redirection vers Stripe :", data.url)
          localStorage.removeItem("cart") // vide le panier après redirection
          window.location.href = data.url
        } else {
          alert("❌ Paiement impossible.")
          console.error("Détails :", data)
        }
      })
      .catch(err => {
        console.error("🌐 Erreur réseau :", err)
        alert("Une erreur réseau est survenue.")
      })
  }
}
