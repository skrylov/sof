require 'rails_helper'

feature 'Add files to answers', %q{
in order to illustrate my answer
As an answer's author
I want to be able to attach files
} do

  given(:user) { create(:user)}
  given(:question) { create(:question) }

  background do
    login(user)
    visit question_path(question)

  end

  scenario 'User adds file when asks question' do
    fill_in 'Your answer', with: 'Test answer'
    attach_file 'File', "#{Rails.root}/spec/spec_helper.rb"

    click_on 'Create'

    within '.answers' do
      expect(page).to have_link 'spec_helper.rb', href: '/uploads/attachmnet/file/1/spec_helper.rb'
    end

  end
end