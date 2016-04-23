require 'rails_helper'

feature 'Can view individual posts' do
  background do
    user = create(:user)
    @post = create(:post, caption: "This is a post number one", user_id: user.id)

    sign_in_with user
  end

  scenario 'can click on post image and view single post' do
    find(:xpath, "//a[contains(@href, 'posts/#{@post.id}')]").click
    expect(page.current_path).to eq(post_path(@post))
  end
end
