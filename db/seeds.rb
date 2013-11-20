# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

10.times do |i| 
  Startup.create!([email: "test#{i}@test.com",
                  name: "Startup de teste #{i}",
                  website: "http://www.startup.com.br",
                  pitch: "Apenas mais um PITCH da startup",
                  description: "Apenas mais uma DESCRIÇÃO da startup",
                  status: Phase::IN_DEVELOPMENT,
                  screenshot: File.open(Rails.root.join('spec', 'fixtures', 'photo.png')),
                  state: "Rio Grande do Sul",
                  city: "Porto Alegre",
                  market_list: "Fitness#{i}, Food#{i}, Startups#{i}",
                  password: "123123123",
                  highlighted: false,
                  status: Status::APPROVED])
end

10.times do |i|
  10.times do |j|
    Questionnaire.create!([ 
      startup: Startup.find(i+1), 
      email: "feedback_#{j}#{i}@test.com", 
      a1: "text", 
      a2: A2::N, 
      a3: A3::N, 
      a4: A4::N, 
      a5: A5::RANGE1, 
      opinion: "text",
      created_at: Time.now-(j+1).day
    ])
  end
end
