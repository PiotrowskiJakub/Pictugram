require 'rails_helper'

feature 'Index displays a list of posts' do
  background do
    user = create(:user)
    post_one = create(:post, caption: "This is the first post", user_id: user.id)
    post_two = create(:post, caption: "This is the second post", user_id: user.id)

    sign_in_with user
  end

  scenario 'the index displays correct created job information' do
    expect(page).to have_content("This is the first post")
    expect(page).to have_content("This is the second post")
    expect(page).to have_css("img[src*='mountains']")
  end
end
