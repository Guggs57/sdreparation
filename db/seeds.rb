AdminUser.create!(
  email: "admin@sdpreparation.com",
  password: "motdepassefort",
  password_confirmation: "motdepassefort"
)

# Création d'articles de démonstration
10.times do |i|
  Product.create!(
    name: "Article #{i + 1}",
    description: "Description technique de l'article #{i + 1} pour scooters 2T.",
    price: rand(100..500),
    image_url: "https://via.placeholder.com/300x200?text=Article+#{i + 1}"
  )
end