require 'rails_helper'

feature 'User authentication' do
  background do
    @user = create(:user)
  end

  scenario 'can log in from the index via dynamic navbar' do
    sign_in_with @user

    expect(page).to have_content('Signed in successfully.')
    expect(page).to_not have_content('Register')
    expect(page).to have_content('Logout')
  end

  scenario 'can log out once logged in' do
    sign_in_with @user

    click_link 'Logout'
    expect(page).to have_content('Signed out successfully.')
  end

  scenario 'cannot create a new post without logging in' do
    visit '/'
    expect(page).to_not have_content('New Post')
  end
end
