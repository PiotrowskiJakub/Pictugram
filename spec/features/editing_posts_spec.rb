require 'rails_helper'

feature 'Editing posts' do
  background do
    post = create(:post)

    visit '/'
    find(:xpath, "//a[contains(@href, 'posts/1')]").click
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

    expect(page). to have_content('Update failed. Please check the form.')
  end
end
