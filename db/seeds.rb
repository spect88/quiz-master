# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

# Clear previously seeded data
User.where(provider: 'seeds.rb').destroy_all

# This user won't be able to sign in, but at least we can display their name.
user = User.create!(
  provider: 'seeds.rb',
  uid: 'example user',
  info: {
    name: 'John Doe',
    nickname: 'jdoe',
    email: 'john.doe@test.com',
    image: 'https://www.gravatar.com/avatar/000?s=480&d=retro'
  }
)

quiz = Quiz.create!(
  user_id: user.id,
  title: 'How much do you know about English alphabet?',
  description: 'This quiz will test your knowledge of the English alphabet',
  content: {
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
)
