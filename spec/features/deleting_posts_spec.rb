require 'rails_helper'

feature 'Can delete a post' do
  background do
    post = create(:post, caption: 'I will be deleted')

    visit '/'
    find(:xpath, "//a[contains(@href, 'posts/1')]").click
  end

  scenario 'after click on delete button in post view' do
    click_link "Delete Post"

    expect(page).to have_content('Post deleted!')
    expect(page).to_not have_content('I will be deleted')
  end
end
