# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
User.delete_all
User.create!(
  first_name: 'Dan',
  last_name: "Mello",
  email: 'admin@example.com',
  summoner: 'MFVico',
  summoner_id: '30323679',
  password: 'password'
)
User.create!(
  first_name: 'Nerdy',
  last_name: 'Nature',
  email: 'user1@example.com',
  summoner: 'nerdybynature28',
  summoner_id: '21804085',
  password: 'password'
)
User.create!(
  first_name: 'Lung',
  last_name: 'Young',
  email: 'user2@example.com',
  summoner: 'younglung',
  summoner_id: '49185715',
  password: 'password'
)
User.create!(
  first_name: 'Lily',
  last_name: 'Anna',
  email: 'user3@example.com',
  summoner: 'liliana519',
  summoner_id: '62551749',
  password: 'password'
)
User.create!(
  first_name: 'Dota',
  last_name: 'Fanboy',
  email: 'user4@example.com',
  summoner: 'dotabase',
  summoner_id: '63413816',
  password: 'password'
)
User.create!(
  first_name: 'Unpaid',
  last_name: 'Bitch',
  email: 'user5@example.com',
  summoner: 'tecre',
  summoner_id: '37909763',
  password: 'password'
)
