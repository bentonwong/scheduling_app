# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

BUG_ENGINEERS = [
  'Smith',
  'Johnson',
  'Williams',
  'Jones',
  'Brown',
  'Davis',
  'Miller',
  'Wilson',
  'Mary',
  'Ivy',
  'James',
  'Linda',
  'Elizabeth',
  'Maria',
  'Andy',
  'Edward'
]

BUG_ENGINEERING_TEAM = 'Bug Engineers'

BUG_ENGINEERS.each do |employee|
  Employee.create(name: employee, assignable: true, role: 'employee')
end

Team.create(name: BUG_ENGINEERING_TEAM, start_day: 0, shift_length: 7)
