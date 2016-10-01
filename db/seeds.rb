100.times do |n|
  #n = 0~99
  password = "password"

  User.create!(
    name: Faker::Name.name,
    email: Faker::Internet.email,
    password: password,
    password_confirmation: password,
    uid: SecureRandom.uuid,
    )
  User.all.sample.topics.create!(
    content: Faker::Lorem.characters(rand(100)),
    )

  topic = Topic.all.sample
  rand(20).times do |comment_number|
    user = User.all.sample
    topic.comments.create!(
      user_id: user.id,
      topic_id: topic.id, 
      content: Faker::Lorem.characters(rand(100)),
      )
  end
end