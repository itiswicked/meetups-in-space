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
      name: 'Duck Gathering',
      description: 'A gathering of majestic fowl.'
    )
  }

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
end
