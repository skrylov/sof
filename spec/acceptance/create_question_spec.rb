require 'rails_helper'

feature 'Create question', %q{
        In order to get an answer from community
        As an authenticated user
        I want to be able to ask question
                         }do

  given!(:user) { create(:user) }

  scenario 'Authenticated user creates questions' do
    login(user)

    visit questions_path
    click_on 'Ask question'
    fill_in 'Title', with: 'Test question'
    fill_in 'Text', with: 'some text'
    click_on 'Create'

    expect(page).to have_content 'Your question successfully created'
    expect(page).to have_content 'Test question'
    expect(page).to have_content 'some text'
end


  scenario 'Non-authenticated user tries to create question' do
    visit questions_path

    click_on 'Ask question'
    expect(page).to have_content 'You need to sign in or sign up before continuing.'
    expect(current_path).to eq new_user_session_path
    end

  end