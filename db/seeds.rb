# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)


Category.create(name: "Харчування", description: "Витрати на їжу")
Category.create(name: "Дозвілля", description: "Витрати на відпочинок")
Category.create(name: "Здоров'я", description: "Витрати на оздоровлення")
Category.create(name: "Автомобіль", description: "Витрати на утримання авто")
Category.create(name: "Домашні тварини", description: "Витрати на утримання тварин")

Category.create(name: "Зарплата", description: "Доходи від роботи")
Category.create(name: "Інші доходи", description: "Непередбачувані доходи")

Operation.create(category_id: 1, amount: 10,  odate: "2023-06-14", description: "опис витрат")
Operation.create(category_id: 1, amount: 120, odate: "2023-06-13", description: "опис витрат")
Operation.create(category_id: 1, amount: 45,  odate: "2023-06-12", description: "опис витрат")
Operation.create(category_id: 1, amount: 17,  odate: "2023-06-11", description: "опис витрат")
Operation.create(category_id: 1, amount: 130, odate: "2023-06-10", description: "опис витрат")
Operation.create(category_id: 2, amount: 100, odate: "2023-06-15", description: "опис витрат")
Operation.create(category_id: 2, amount: 190, odate: "2023-06-17", description: "опис витрат")
Operation.create(category_id: 2, amount: 180, odate: "2023-06-23", description: "опис витрат")
Operation.create(category_id: 2, amount: 150, odate: "2023-06-26", description: "опис витрат")
Operation.create(category_id: 2, amount: 200, odate: "2023-06-24", description: "опис витрат")
