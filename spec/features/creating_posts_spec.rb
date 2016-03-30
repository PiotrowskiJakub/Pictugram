require 'rails_helper.rb'

feature 'Creating posts' do
  scenario 'can create a job' do
    visit '/'
    click_link 'New Post'
    attach_file('Image', "spec/files/images/mountains.jpg")
    fill_in 'Caption', with: 'Beautiful view #travel #breathtaking #moments'
    click_button 'Create Post'
    expect(page).to have_content('#breathtaking')
    expect(page).to have_css("img[src*='mountains.jpg']")
  end

  it 'needs an image to create a post' do
    visit '/'
    click_link 'New Post'
    fill_in 'Caption', with: '#autumn #sun #leafs'
    click_button 'Create Post'
    expect(page).to have_content("Your new post couldn't be created! Please check the form")
  end
end
