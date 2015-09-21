# == Schema Information
#
# Table name: goals
#
#  id         :integer          not null, primary key
#  title      :string           not null
#  user_id    :integer          not null
#  text       :text             not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  completed  :boolean          default(FALSE)
#  personal   :boolean          default(FALSE)
#

FactoryGirl.define do
  factory :goal do
    title "Make a new goal"
    user_id 1
    text "My first goal is to create a goal. Today is gonna be the day. Just do it! Semper Fi!"

    factory :private_goal do
      personal true
      title "Secret goal seen by no one"
      text "This goal is my secret goal :("
    end

    factory :completed_goal do
      completed true
    end

  end

  factory :other_guys_goal, class: "Goal" do
    title "Not be user 1"
    text "That guy is the worst.  My goal is to not be him."
    user_id 2
  end

  factory :random_goal, class: "Goal" do
    title { Faker::Lorem.words(num = 6) }
    user_id 1
    text { Faker::Lorem.paragraph(sentence_count = 4)}
  end

end
