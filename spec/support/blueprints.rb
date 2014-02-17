require 'machinist/active_record'

# Add your blueprints here.
#
# e.g.
#   Post.blueprint do
#     title { "Post #{sn}" }
#     body  { "Lorem ipsum..." }
#   end

AdminUser.blueprint do
  # Attributes here
end

Startup.blueprint do
  email { "startup_#{sn}@test.com" }
  name { "Startup de teste #{sn}" }
  website { "http://www.startup#{sn}.com.br" }
  pitch { "Apenas mais um PITCH da startup #{sn}" }
  description { "Apenas mais uma DESCRIÇÃO da startup #{sn}" }
  phase { Phase::IN_DEVELOPMENT }
  screenshot { File.open(Rails.root.join('spec', 'fixtures', 'photo.png')) }
  state { "Rio Grande do Sul" }
  city { "Porto Alegre" }
  market_list { "Fitness, Food, Startups" }
  password { "123123123" }
  highlighted { false }
  status { Status::PENDENT }
end

Questionnaire.blueprint do
  startup { Startup.make! }
  email { "feedback_#{sn}@test.com" }
  a1 { "text" }
  a2 { A2::N }
  a3 { A3::N }
  a4 { A4::N }
  a5 { A5::RANGE1 }
  opinion { "text" }
end

StartupPackSubscriber.blueprint do
  email { "subscriber_#{sn}@test.com" }
end
