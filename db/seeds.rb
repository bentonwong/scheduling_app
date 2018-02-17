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

@bug_engineering_team = Team.create(name: BUG_ENGINEERING_TEAM, start_day: 1, shift_length: 5)
BUG_ENGINEERS.each do |employee|
  @bug_engineering_team.employees.build(name: employee, assignable: true, admin: false)
end
@bug_engineering_team.save

Employee.create(name:'ADMIN MODE', assignable: false, admin: true);
