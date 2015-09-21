require 'rails_helper'


feature 'goals work' do
  given(:user) { FactoryGirl.create(:user) }
  given(:user2) { FactoryGirl.create(:other_user) }
  given(:goal) { FactoryGirl.create(:goal, user_id: user.id) }
  given(:goal2) { FactoryGirl.create(:other_guys_goal, user_id: user2.id) }
  given(:privategoal) { FactoryGirl.create(:private_goal, user_id: user.id) }
  given(:privategoal2) { FactoryGirl.create(:private_goal, user_id: user2.id) }

feature 'user can create a new goal' do
  # logged in users only

  scenario "can't create a goal when logged out" do
    visit new_goal_url
    expect(current_path).to eq(new_session_path)
  end

  scenario 'can create own goal when logged in' do
    login_ok_user
    goal = create_new_goal
    expect(page).to have_content('Goal created!')
  end

end

feature 'user can edit their goals' do

  # given(:user) { FactoryGirl.create(:user) }
  # given(:user2) { FactoryGirl.create(:other_user) }
  # given(:goal) { FactoryGirl.create(:goal) }
  # given(:goal2) { FactoryGirl.create(:other_guys_goal) }

  background do
    login_user(user)
  end

  scenario 'user can edit a goal belonging to them' do
    visit edit_goal_url(goal)
    fill_in "Title", with: "Different title for my goal"
    click_button "Update Goal"
    expect(page).to have_content('Goal updated')
  end

  scenario 'user cannot edit a goal not belonging to them' do
    visit edit_goal_url(goal2)
    expect(current_path).to eq(users_path)
  end

end

feature 'users can view goals' do


  background do
    login_user(user2)
  end

  scenario 'user index page shows goals' do
    visit user_url(user)
    save_and_open_page
    expect(page).to have_content(goal.title)
  end

  scenario 'user index page does not show private goals' do
    visit user_url(user)
    expect(page).not_to have_content(privategoal.title)
  end

  scenario 'show page for a goal shows its title and text' do
    visit goal_url(goal)
    expect(page).to have_content(goal.title)
    expect(page).to have_content(goal.text)
  end

  scenario 'user can see own private goals' do
    visit user_url(user2)
    expect(page).to have_content(privategoal2.title)
  end

end

feature 'users can delete goals' do

    # given(:user) { FactoryGirl.create(:user) }
    # given(:user2) { FactoryGirl.create(:other_user) }
    # given(:goal) { FactoryGirl.create(:goal) }
    # given(:goal2) { FactoryGirl.create(:other_guys_goal) }

  background do
    login_user(user2)
  end

  scenario 'can delete own goals' do
    visit goal_url(goal2)
    click_button "Delete Goal"
    expect(current_path).to eq(user_path(user2))
    expect(page).to have_content("Goal deleted!")
    visit goal_url(goal)
    (400 .. 599).should include(page.status_code)
  end

  scenario 'cannot delete other user goals' do
    visit goal_url(goal)
    expect(page).not_to have_button("Delete Goal")
  end

end
end
