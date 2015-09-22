require 'rails_helper'


feature 'comments work' do

  given(:user1) { FactoryGirl.create(:user) }
  given(:user2) { FactoryGirl.create(:other_user) }
  given(:user3) { FactoryGirl.create(:random_user) }
  given(:goal1) { FactoryGirl.create(:goal, user_id: user2.id) }
  given(:usercomment) { FactoryGirl.create(:comment, user_id: user2.id, commentable_id: user1.id) }
  given(:goalcomment) { FactoryGirl.create(:goal_comment, user_id: user2.id, commentable_id: goal1.id) }

  scenario 'users can comment on other users' do
    login_user(user1)
    visit_page user_url(user2)
    fill_in "Comment", with: "Some test comment on user2's page"
    click_button "Add Comment"
    expect(page).to have_content("Some test comment on user2's page")
  end

  scenario 'users can comment on goals' do
    login_user(user1)
    visit_page goal_url(goal1)
    fill_in "Comment", with: "this is a comment on a goal"
    click_button "Add Comment"
    expect(page).to have_content("this is a comment on a goal")
  end

  scenario 'users can edit comments they wrote' do
    login_user(user2)
    usercomment
    visit_page(user_url(user1))
    click_button "Edit Comment"
    fill_in "Comment", with: "this is the updated comment text"
    click_button "Update Comment"
    expect(page).to have_content("this is the updated comment text")
  end

  scenario 'users cannot edit other users comments' do
    login_user(user3)
    usercomment
    visit_page(user_url(user1))
    expect(page).not_to have_button("Edit Comment")
  end

  scenario 'users can destroy comments on their user or goal pages' do
    login_user(user1)
    usercomment
    visit_page(user_url(user1))
    click_button "Delete Comment"
    expect(page).not_to have_content(usercomment.body)

  end

  scenario 'users can destroy comments they wrote' do
    login_user(user2)
    usercomment
    visit_page(user_url(user1))
    click_button "Delete Comment"
    expect(page).not_to have_content(usercomment.body)
  end

  scenario 'users cannot destroy comments they did not write or are not on their pages' do
    login_user(user3)
    usercomment
    visit_page(user_url(user1))
    expect(page).not_to have_button("Delete Comment")
  end

end
