FactoryGirl.define do
  factory :comment do
    commentable_type "User"
    body "Here's my user comment."

      factory :goal_comment do
      commentable_type "Goal"
      body "Here's my goal comment."
    end
  end
end
