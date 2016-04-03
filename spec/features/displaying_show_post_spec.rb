require 'rails_helper'

feature 'Can view individual posts' do
  scenario 'can click on post image and view single post' do
    post = create(:post, caption: "This is a post number one")

    visit '/'
    find(:xpath, "//a[contains(@href, 'posts/1')]").click
    expect(page.current_path).to eq(post_path(post))
  end
end
