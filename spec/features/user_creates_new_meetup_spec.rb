require 'spec_helper'

# As a user
# I want to create a meetup
# So that I can gather a group of people to do an activity

feature 'user creates a new meetup' do

  let(:user) do
    User.create(
      provider: 'github',
      uid: '1',
      username: 'itiswicked',
      email: 'nathanrbourke@gmail.com',
      avatar_url: 'https://avatars3.githubusercontent.com/u/8851553?v=3&s=460'
    )
  end
  before(:each) { visit '/' }

  scenario 'when not logged in, user is denied access' do
    click_link 'Create New Meetup'
    expect(page).to have_content 'You must be logged in to perform that action.'
  end

  scenario 'when logged in, creates new event and redirects to show page' do
    sign_in_as user
    click_link 'Create New Meetup'
    expect(page).to have_content 'New Meetup'
    fill_in :name, with: 'Mordenkeinen\'s Birthday'
    fill_in :description, with: 'A Circle of Eight sponsored event. We don\'t mean to be classist, but Wizards only.'
    fill_in :location, with: 'The Citidel of Eight'
    click_button 'Submit'
    expect(page).to have_content 'Mordenkeinen\'s Birthday'
    expect(page).to have_content 'The Citidel of Eight'
  end

end
