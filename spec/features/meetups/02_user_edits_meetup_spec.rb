require 'spec_helper'

feature 'edit meetup', js: true do

  let!(:wrong_user) do
    User.create(
      provider: 'github',
      uid: '2',
      username: 'itiswicked03',
      email: 'nathanrbourke3@gmail.com',
      avatar_url: 'https://avatars3.githubusercontent.com/u/8851553?v=3&s=460'
    )
end

  let!(:right_user) do
    User.create(
      provider: 'github',
      uid: '1',
      username: 'itiswicked',
      email: 'nathanrbourke@gmail.com',
      avatar_url: 'https://avatars3.githubusercontent.com/u/8851553?v=3&s=460'
    )
  end

  let!(:meetup) do
    Meetup.create(
      user: right_user,
      name: 'Duck Gathering',
      description: 'A gathering of majestic fowl.'
    )
  end

  context 'when meetup not owned by currently signed in user' do
    scenario 'unsuccessfully edits meetup' do
      visit '/'
      sign_in_as wrong_user
      click_link 'Duck Gathering'

      expect(page).to_not have_content "Edit Meetup"
    end
  end


  context 'when meetup owned by currently signed in user' do
    scenario 'successfully edits meetup' do
      visit '/'
      sign_in_as right_user
      click_link 'Duck Gathering'
      expect(page).to have_content 'Edit This Meetup'

      click_link 'Edit This Meetup'
      expect(find_field('name').value).to have_content 'Duck Gathering'

      fill_in 'name', with: 'Duck Meeting'
      click_button 'Submit'
      expect(page).to have_content 'Duck Meeting'
    end
  end

end
