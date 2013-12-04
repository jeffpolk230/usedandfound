# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

Category.create :category_title => 'Books'
Category.create :category_title => 'Bikes'
Category.create :category_title => 'Stationaries'
Category.create :category_title => 'Gadgets'
