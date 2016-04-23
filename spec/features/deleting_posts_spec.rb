require 'rails_helper'

feature 'Can delete a post' do
  background do
    user = create(:user)
    @post = create(:post, caption: 'I will be deleted', user_id: user.id)

    sign_in_with user

    find(:xpath, "//a[contains(@href, 'posts/#{@post.id}')]").click
  end

  scenario 'after click on delete button in post view' do
    click_link "Delete Post"

    expect(page).to have_content('Post deleted!')
    expect(page).to_not have_content('I will be deleted')
  end

  scenario 'can not delete another user post' do
    user = create(:user, email:"adam@gmail.com", user_name: "Adam Czartoryski")
    display_post_as_new_user(user, @post)

    expect(page).to_not have_content('Delete Post')
  end
end
