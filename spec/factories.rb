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
            question: 'How many vowels are there in the English alphabet?',
            answer: '5'
          }
        ]
      }
    end
  end

  factory :quiz_result do
    user
    quiz
    score 1
    max_score 2
    details do
      {
        questions: [
          {
            question: 'How many letters are there in the English alphabet?',
            answer: 'twenty-six',
            correct: true,
            expected: '26'
          },
          {
            question: 'How many vowels are there in the English alphabet?',
            answer: '4',
            correct: false,
            expected: '5'
          }
        ]
      }
    end
  end
end
