require 'rails_helper'

feature 'User answer', %q{
        In order to exchange my knowledge
        As an authenticated user
        I want to be able to create answers
                     } do

  given(:user) { create(:user) }
  given!(:question) { create(:question) }

  scenario 'Authenticated user creates answer', js: true do
    login(user)
    visit question_path(question)

    fill_in 'Your answer', with: 'My answer'
    click_on 'Create'

    expect(current_path).to eq question_path(question)
    within '.answers' do
      expect(page).to have_content 'My answer'
    end
  end

  scenario 'user tries to create invalid answer', js: true do
    login(user)
    visit question_path(question)

    click_on 'Create'
    within '.answers-errors' do
      expect(page).to have_content "Body can't be blank"
    end

  end

end