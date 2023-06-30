# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)


Category.create(name: "Кафе, ресторан", description: "Витрати на харчування в закладах громадського харчування")
Category.create(name: "Дозвілля", description: "Витрати на відпочинок (кіно, розваги, )")
Category.create(name: "Здоров'я", description: "Витрати на ліки, медичні послуги")
Category.create(name: "Автомобіль", description: "Витрати на утримання авто (пальне, запчастини, послуши СТО, мійка)")
Category.create(name: "Домашні тварини", description: "Витрати на утримання тварин (іжа, іграшки, аксесуари, ветеринарія)")
Category.create(name: "Продукти", description: "Витрати на продукти харчування")
Category.create(name: "Подорожі", description: "Витрати на подорожі (квитки, аренда житла, інші витрати під час подорожі)")
Category.create(name: "Хоббі", description: "Витрати на власне хоббі")
Category.create(name: "Одяг", description: "Витрати на одяг, взуття, аксесуари")
Category.create(name: "Навчання", description: "Витрати на власний розвиток, оплата навчання, літератури тощо")
Category.create(name: "Інші витрати", description: "Непередбачувані, разові витрати, що не відносяться до інших категорій")


500.times do
  operation = Operation.new(
    category_id: Faker::Number.within(range: Category.first.id..Category.last.id) ,
    amount: Faker::Number.within(range: 10..1000) ,
    odate: Faker::Date.between(from: "2023-03-01", to: Date.today), 
    description: "тут має бути опис витрат..."
  )
  operation.save
end
 