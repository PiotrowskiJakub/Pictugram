require 'rails_helper'

feature 'Deleting comments' do
  background do
    user = create(:user)
    @post = create(:post, user_id: user.id)
    @comment = create(:comment, user_id: user.id, post_id: @post.id)

    sign_in_with user
  end

  scenario 'user can delete their own comments' do
    expect(page).to have_content('Nice post!')
    find(:xpath, "//a[@href=\"/posts/#{@post.id}/comments/#{@comment.id}\"]").click
    expect(page).to_not have_content('Nice post!')
  end

  scenario 'user can not delete other user comments' do
    user = create(:user, email:"adam@gmail.com", user_name: "Adam Czartoryski")
    sign_again_with(user)

    expect(page).to_not have_css("//a[@href=\"/posts/#{@post.id}/comments/#{@comment.id}\"]")
  end
end
