ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../../config/environment', __FILE__)

abort("The Rails environment is running in production mode!") if Rails.env.production?
require 'spec_helper'
require 'rspec/rails'
require 'capybara/rails'

ActiveRecord::Migration.maintain_test_schema!

module AuthHelpers
  def sign_in_with (user)
    visit '/'
    click_link 'Login'
    fill_in 'Email', with: user.email
    fill_in 'Password', with: user.password
    click_button 'Log in'
  end

  def sign_again_with (user)
    click_link 'Logout'
    sign_in_with user
  end

  def display_post_as_new_user (user, post)
    sign_again_with user
    find(:xpath, "//a[contains(@href, 'posts/#{post.id}')]").click
  end

  def prepare_users_and_posts
    user = create(:user)
    user_two = create(:user, email: 'anthony@gmail.com', user_name: 'antbu')
    post = create(:post, user_id: user.id)
    post_two = create(:post, caption: 'Second post', user_id: user_two.id)

    sign_in_with(user)
    visit '/'
  end
end

RSpec.configure do |config|
  config.fixture_path = "#{::Rails.root}/spec/fixtures"
  config.use_transactional_fixtures = true
  config.infer_spec_type_from_file_location!
  config.filter_rails_from_backtrace!
  config.include FactoryGirl::Syntax::Methods
  config.include AuthHelpers, type: :feature
end
