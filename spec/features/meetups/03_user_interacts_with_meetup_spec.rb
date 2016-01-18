require 'spec_helper'

# As a user
# I want to join a meetup without a page reload
# So that I can have a seamless experience when joining a meetup
#
# Acceptance Criteria:
#
#   If I click the join meetup button, I will join the meetup without refreshing
#   the page.

#   I should see the join meetup up button become the leave meetup
#   button, I should be added to the meetup's members list, and I should NOT see
#   a message saying that I've successfully joined a meetup.

#   If a user disables javascript, the join meetup functionality should still
#   work with a page relaod (hint: create new route that your AJAX request
#   utilizes rather than rewriting the original route).

feature 'user_interacts_with_meetup', js: true do

  let!(:user) do
    User.create(
      provider: 'github',
      uid: '1',
      username: 'itiswicked',
      email: 'nathanrbourke@gmail.com',
      avatar_url: 'https://avatars3.githubusercontent.com/u/8851553?v=3&s=460'
    )
  end

  let!(:meetup) {
    Meetup.create(
    user: user,
    name: 'Duck Gathering',
    description: 'A gathering of majestic fowl.'
    )
  }

  before(:each) { visit '/' }

  context 'when signed in' do
    scenario 'joins meetup that has already been created' do
      sign_in_as user

      click_link 'Duck Gathering'
      click_link "Join!"
      expect(page).to have_content(user.username)
      expect(page).to have_content("Leave Meetup")
    end
  end

  context 'when not signed in' do
    scenario 'will not see join button' do
      click_link 'Duck Gathering'

      expect(page).to_not have_content("Join!")
    end
  end

end
