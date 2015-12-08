require 'spec_helper'

feature 'user views meetups', js: true do

  let(:meetup) {
    Meetup.create(
      name: 'Duck Gathering',
      description: 'A gathering of majestic fowl.'
    )
  }

  scenario 'user visits index page' do
    meetup
    visit '/meetups'
    expect(page).to have_content('Duck Gathering')
  end


  scenario 'user visits show page for specific meetup' do
    meetup
    visit '/meetups'

    click_link 'Duck Gathering'
    expect(page).to have_content('Duck Gathering')
    expect(page).to have_content('A gathering of majestic fowl')
  end
end
