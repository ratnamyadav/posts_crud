FactoryBot.define do
  factory :post do |f|
    f.title              { Faker::Company.bs }
    f.description        { Faker::ChuckNorris.fact }
    f.created_by         { Faker::Name }
  end
end