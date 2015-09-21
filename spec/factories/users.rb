# == Schema Information
#
# Table name: users
#
#  id              :integer          not null, primary key
#  username        :string           not null
#  password_digest :string           not null
#  session_token   :string           not null
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#

FactoryGirl.define do
  factory :user do
    username "breakfast"
    password "password"
    factory :bad_password_user do
      password "bad"
    end

    factory :other_user do
      username "jenkins"
    end
  end

  factory :random_user do
    username Faker::Internet.user_name
    password Faker::Internet.password
  end
end
