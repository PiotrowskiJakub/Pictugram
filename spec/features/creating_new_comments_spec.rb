require 'rails_helper'

feature 'Creating comments' do
  scenario 'can comment on an existing post' do
    user = create(:user)
    post = create(:post, user_id: user.id)
    sign_in_with user

    text = 'Cool!'
    fill_in 'Add a comment...', with: text
    click_button 'add_comment'
    expect(page).to have_css("div#comments_#{post.id}", text: text)
  end
end
