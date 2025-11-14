FactoryBot.define do
  factory :task do
    title { "MyString" }
    description { "MyText" }
    due_date { "2025-11-14" }
    parent { nil }
  end
end
