FactoryBot.define do
    factory :message do
        body { Faker::Lorem.word }
        name { Faker::Lorem.word }
    end
  end