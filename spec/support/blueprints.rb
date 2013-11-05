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
  status { Status::IN_DEVELOPMENT }
  screenshot { File.open(Rails.root.join('spec', 'fixtures', 'photo.png')) }
  state { "Rio Grande do Sul" }
  city { "Porto Alegre" }
  markets { "Fitness, Food, Startups" }
  password { "123123123" }
  highlighted { false }
  approved { false }
end
