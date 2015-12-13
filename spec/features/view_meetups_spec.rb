require 'spec_helper'

# As a user
# I want to view a list of all available meetups
# So that I can get together with people with similar interests

# As a user
# I want to view the details of a meetup
# So that I can learn more about its purpose

feature 'user views meetups', js: true do

  let!(:meetup) {
    Meetup.create(
     user_id: '1',
      name: 'Duck Gathering',
      description: 'A gathering of majestic fowl.'
    )
  }

  let!(:user) do
    User.create(
      provider: 'github',
      uid: '1',
      username: 'itiswicked',
      email: 'nathanrbourke@gmail.com',
      avatar_url: 'https://avatars3.githubusercontent.com/u/8851553?v=3&s=460'
    )
  end

  scenario 'user visits index page' do
    visit '/meetups'
    expect(page).to have_content('Duck Gathering')
  end

  scenario 'user visits show page for specific meetup' do
    visit '/meetups'
    click_link 'Duck Gathering'
    expect(page).to have_content('Duck Gathering')
    expect(page).to have_content('A gathering of majestic fowl')
  end

  scenario 'user sees other users attending meetups' do
    meetup.users << user
    visit '/meetups/1'
    expect(page).to have_content('itiswicked')
    page
      .find('img')['src']
      .should have_content 'https://avatars3.githubusercontent.com/u/8851553?v=3&s=460'
  end
end
