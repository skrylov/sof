FactoryGirl.define do
  factory :answer do
    body "My text"
    question ""
  end

  factory :invalid_answer, class: 'Answer' do
    body nil
  end
end