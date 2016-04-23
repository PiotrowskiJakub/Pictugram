require 'rails_helper'

feature 'Can delete a post' do
  background do
    user = create(:user)
    post = create(:post, caption: 'I will be deleted', user_id: user.id)

    sign_in_with user

    find(:xpath, "//a[contains(@href, 'posts/#{post.id}')]").click
  end

  scenario 'after click on delete button in post view' do
    click_link "Delete Post"

    expect(page).to have_content('Post deleted!')
    expect(page).to_not have_content('I will be deleted')
  end
end
