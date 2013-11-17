# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

10.times do
  Startup.create!([email: "test#{sn}@test.com",
                  name: "Startup de teste #{sn}",
                  website: "http://www.startup.com.br",
                  pitch: "Apenas mais um PITCH da startup",
                  description: "Apenas mais uma DESCRIÇÃO da startup",
                  status: Status::IN_DEVELOPMENT,
                  screenshot: File.open(Rails.root.join('spec', 'fixtures', 'photo.png')),
                  state: "Rio Grande do Sul",
                  city: "Porto Alegre",
                  market_list: "Fitness#{sn}, Food#{sn}, Startups#{sn}",
                  password: "123123123",
                  highlighted: false,
                  approved: true])
end
