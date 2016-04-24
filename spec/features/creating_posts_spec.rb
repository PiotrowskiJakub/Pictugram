require 'rails_helper'

feature 'Creating posts' do
  background do
    @user = create(:user)
    sign_in_with @user

    visit '/'
    click_link 'New Post'
  end

  scenario 'can create a post' do
    attach_file('post_image', "spec/files/images/mountains.jpg")
    fill_in 'post_caption', with: 'Beautiful view #travel #breathtaking #moments'
    click_button 'Create Post'
    expect(page).to have_content('#breathtaking')
    expect(page).to have_css("img[src*='mountains.jpg']")
    expect(page).to have_content(@user.user_name)
  end

  it 'needs an image to create a post' do
    fill_in 'post_caption', with: '#autumn #sun #leafs'
    click_button 'Create Post'
    expect(page).to have_content("Your new post couldn't be created! Please check the form")
  end
end
