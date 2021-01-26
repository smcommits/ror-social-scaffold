require 'rails_helper'

describe 'the signin process', type: :feature do
  user = FactoryBot.create(:user)
  context 'Creating posts'

  it 'cannot create a post if user is not logged in' do
    visit '/posts/'
    expect(page).to have_current_path(new_user_session_path)
  end

  it 'creates a post if user is signed in' do
    login_as(user, scope: :user)

    visit '/posts/'
    within('#new_post') do
      fill_in 'post_content', with: 'My First Post'
    end
    click_button 'Save'
    expect(page).to have_content 'Post was successfully created'
  end
end
