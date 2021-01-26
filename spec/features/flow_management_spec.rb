require 'rails_helper'

describe 'application_flow', type: :feature do
  user = FactoryBot.create(:user)

  scenario 'should redirect to new session path if visited root path withtout loggin in' do
    visit '/'
    expect(page).to have_current_path(new_user_session_path)
  end

  scenario 'should let user access the root path if logged in' do
    login_as(user, scope: :user)
    visit '/'
    expect(page).to have_current_path(root_path)
  end

  scenario 'will render posts page is user was unable to create a post' do
    visit '/'
    login_as(user, scope: :user)
    visit '/posts/'
    click_button 'commit'
    expect(page).to have_content("Post could not be saved. Content can't be blank")
    expect(page).to have_current_path(posts_path)
  end

  scenario 'should redirect to posts page if post is created' do
    visit '/'
    login_as(user, scope: :user)
    visit '/posts/'
    within('#new_post') do
      fill_in 'post_content', with: 'My First Post'
    end
    click_button 'commit'
    expect(page).to have_content('Post was successfully created')
    expect(page).to have_current_path(posts_path)
  end
end
