class Answer < ActiveRecord::Base
  beongs_to :question

  validates :body, question_id, presence: true
end
