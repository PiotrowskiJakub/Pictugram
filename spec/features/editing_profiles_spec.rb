require 'rails_helper'

feature 'Editing user profiles' do
  background do
    prepare_users_and_posts
  end

  scenario 'a user can change their own profile details' do
    first('.user-name').click_link 'jakupiot'
    click_link 'Edit Profile'
    attach_file('user_avatar', 'spec/files/images/avatar.jpg')
    fill_in 'user_bio', with: 'I have so exciting life!'
    click_button 'Update Profile'

    expect(page.current_path).to eq(profile_path('jakupiot'))
    expect(page).to have_css("img=[src*='avatar']")
    expect(page).to have_content('I have so exciting life!')
  end

  scenario 'a user cannot change someone elses profile picture' do
    first('.user-name').click_link 'antbu'

    expect(page).to_not have_content('Edit Profile')
  end

  scenario 'a user cannot navigate directly to edit a users profile' do
    visit '/jakupiot/edit'

    expect(page).to_not have_content('Change your profile image:')
    expect(page.current_path).to eq(root_path)
    expect(page).to have_content("That profile doesn't belong to you!")
  end
end
