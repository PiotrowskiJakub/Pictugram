require 'rails_helper'

feature 'Editing posts' do
  background do
    user = create(:user)
    @bad_user = create(:user, email:"adam@gmail.com", user_name: "Adam Czartoryski")
    @post = create(:post, user_id: user.id)

    sign_in_with user

    find(:xpath, "//a[contains(@href, 'posts/#{@post.id}')]").click
    click_link "Edit Post"
  end

  scenario 'can edit a post' do
    fill_in 'Caption', with: "What a fancy pictugram!"
    click_button 'Update Post'

    expect(page).to have_content('Post updated!')
    expect(page).to have_content('What a fancy pictugram!')
  end

  scenario 'can not update a post without an image' do
    attach_file('Image', 'spec/files/mountains.zip')
    click_button 'Update Post'

    expect(page).to have_content('Update failed. Please check the form.')
  end

  scenario 'can not edit another user post via the show page' do
    display_post_as_new_user(@bad_user, @post)

    expect(page).to_not have_content('Edit Post')
  end

  scenario 'can not edit another user post via url path' do
    display_post_as_new_user(@bad_user, @post)
    visit current_url + "/edit"

    expect(page).to have_content("That post doesn't belong to you!")
  end
end
