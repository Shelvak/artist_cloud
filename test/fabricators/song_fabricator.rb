Fabricator(:song) do
  file      { File.open(Rails.root.join('test', 'files', 'sample.mp3')) }
  title     { Faker::Lorem.sentence }
  artist    { Faker::Lorem.sentence }
  album     { Faker::Lorem.sentence }
  year      { rand(2000..2020) }
  comment   { Faker::Lorem.sentence }
  track     { rand(12) }
  genre     { Faker::Lorem.sentence }
  user_id   { Fabricate(:user).id }
  version   { rand(99) }
end
