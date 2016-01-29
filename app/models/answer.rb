class Answer < ActiveRecord::Base
  belongs_to :question
  has_many :user
  has_many :attachments, as: :attachmentable, dependent: :destroy


  validates :question_id, :body, presence: true

  accepts_nested_attributes_for :attachments
end
