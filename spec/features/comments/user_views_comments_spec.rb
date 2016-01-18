require 'spec_helper'

feature 'comments', js: true do

  let!(:unjoined_user) { FactoryGirl.create(:user) }
  let!(:joined_user)   { FactoryGirl.create(:user) }

  let!(:meetup) do
    f = FactoryGirl.create(:meetup)
    f.users << joined_user
    f.user = joined_user
    f.save
    f
  end

  let!(:comment) do
    c = FactoryGirl.create(:comment)
    c.user = joined_user
    c.meetup = meetup
    c.save
    c
  end

  before(:each) { visit '/' }

  scenario 'user views comments' do
    click_link 'Duck Gathering'
    expect(page).to have_content joined_user.username
    expect(page).to have_content comment.body
  end

  context 'when not logged in' do
    scenario 'user cannot create comment' do
      click_link 'Duck Gathering'
      expect(page).to_not have_content 'Leave a comment'
    end
  end

  context 'when logged in but has not joined meetup' do
    scenario 'user can only leave comments on meetups they have joined' do
      sign_in_as unjoined_user
      click_link 'Duck Gathering'
      expect(page).to_not have_content 'Leave a comment'
    end
  end

  context 'when logged in and has joined meetup' do

    before :each do
      sign_in_as joined_user
      click_link 'Duck Gathering'
    end

    scenario 'user can create a comments' do
      expect(page).to have_content 'Leave a comment'

      click_link 'Leave a comment'
      expect(page).to have_content 'New Comment'

      fill_in 'body', with: "No way man, that pond is the bees knees"
      click_button 'Submit'
      # redirect to meetups/show
      expect(page).to have_content "No way man"

    end

    scenario 'user can edit a comment they own' do
      expect(page).to have_content 'Edit'

      click_link 'Edit'
      expect(find_field('Comment:').value).to have_content 'No way man'

      fill_in 'Comment:', with: 'No way man, that pond is great'
      click_button 'Submit'
      # redirect to meetups/show
      expect(page).to have_content 'No way man, that pond is great'
    end
  end

end
