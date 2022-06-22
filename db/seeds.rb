# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

u1 = User.create!(email: 'pm1@jazzari.com', password: 'password', role: 'project_manager')
u2 = User.create!(email: 'pm2@jazzari.com', password: 'password', role: 'project_manager')
u3 = User.create!(email: 'qa1@jazzari.com', password: 'password', role: 'qa')
u4 = User.create!(email: 'qa2@jazzari.com', password: 'password', role: 'qa')
u5 = User.create!(email: 'dev1@jazzari.com', password: 'password', role: 'developer')
u6 = User.create!(email: 'dev2@jazzari.com', password: 'password', role: 'developer')

p1 = Project.create!(title: 'Project 1', description: 'This is Project1.')
p2 = Project.create!(title: 'Project 2', description: 'This is Project2.')
p3 = Project.create!(title: 'Project 3', description: 'This is Project3.')

Assign.create!(user_id: u1.id, project_id: p1.id)
Assign.create!(user_id: u3.id, project_id: p1.id)
Assign.create!(user_id: u5.id, project_id: p1.id)

# Bug.create!(title: "Bug 1", comment: "This is bug1.", status: "new_bug", user_id: u5)
