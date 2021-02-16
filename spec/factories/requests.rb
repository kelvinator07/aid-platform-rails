FactoryBot.define do
    factory :request do
        description { Faker::Lorem.word }
        lat { Faker::Number.number }
        lng { Faker::Number.number }
        request_type { 'material_need' } 
    end
  end