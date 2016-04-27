require 'rails_helper'

feature 'Viewing user profiles' do
  background do
    prepare_users_and_posts
    click_link('jakupiot', match: :first)
  end

  scenario 'visiting a profile page shows the user name in the url' do
    expect(page.current_path).to eq(profile_path('jakupiot'))
  end

  scenario "a profile page only shows the specified user's posts" do
    expect(page).to have_content('nofilter')
    expect(page).to_not have_content('Second post')
  end
end
