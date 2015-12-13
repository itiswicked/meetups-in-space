require 'spec_helper'

feature 'join meetup', js: true do

  let!(:meetup) {
    Meetup.create(
      user_id: '1',
      name: 'Duck Gathering',
      description: 'A gathering of majestic fowl.'
    )
  }

  let!(:user) {
    User.create(
      provider: 'github',
      uid: '1',
      username: 'itiswicked',
      email: 'nathanrbourke@gmail.com',
      avatar_url: 'https://avatars3.githubusercontent.com/u/8851553?v=3&s=460'
    )
  }

  context 'when not signed in' do
    scenario 'user unsuccessfully joins meetup' do
      visit '/meetups/1'
      expect(page).to_not have_content "Join!"
    end
  end

  context 'when signed in' do
    scenario 'user successfully joins meetup' do
      visit '/'
      sign_in_as user
      visit '/meetups/1'

      expect(page).to have_content 'Join!'

      click_link 'Join!'
      expect(page).to have_content 'Leave Meetup'
      expect(meetup.users).to include user
    end
  end


end
