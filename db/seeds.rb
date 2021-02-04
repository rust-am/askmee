User.create!(
  name: 'name_test',
  username: 'username_test',
  email: 'test@mail.ru',
  password: '123123'
)

5.times do
  user =
    User.create(
      name: FFaker::Name.unique.name,
      username: FFaker::Internet.unique.domain_word,
      email: FFaker::Internet.free_email,
      avatar_url: FFaker::Avatar.unique.image,
      password: '123123'
    )

  user.questions.create!(
    text: FFaker::Lorem.phrase
  )
end