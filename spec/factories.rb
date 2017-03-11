FactoryGirl.define do

  factory :user do
    sequence(:uid) { |n| "test|#{n}" }
    provider 'factories.rb'
    sequence(:info) do |n|
      {
        name: "Test User #{n}",
        nickname: "user#{n}",
        email: "user#{n}@test.com",
        image: "https://www.gravatar.com/avatar/000#{n}?s=480&d=retro"
      }
    end
  end

  factory :quiz do
    user
    sequence(:title) { |n| "Test Quiz #{n}" }
    description 'Test quiz, defined in spec/factories.rb'
    content do
      {
        questions: [
          {
            question: 'How many letters are there in the English alphabet?',
            answer: '26'
          },
          {
            question: 'Hom many vowels are there in the English alphabet?',
            answer: '5'
          }
        ]
      }
    end
  end

end
