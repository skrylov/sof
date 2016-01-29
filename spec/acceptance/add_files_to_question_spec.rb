require 'rails_helper'

feature 'Add files to question', %q{
        in order to illustrate my question
As a question's author
I want to be able to attach files
} do

  given(:user) { create(:user)}

  background do
    login(user)
    visit new_question_path

  end

  scenario 'User adds file when asks question' do
    fill_in 'Title', with: 'Test question'
    fill_in 'Text', with: 'some text'

    attach_file 'File', "#{Rails.root}/spec/spec_helper.rb"

    click_on 'Create'

    expect(page).to have_link 'spec_helper.rb', href: '/uploads/attachmnet/file/1/spec_helper.rb'
  end
end