class Answer < ActiveRecord::Base
  include Votable
  include Attachable

  belongs_to :question
  has_many :user
  has_many :attachments, as: :attachmentable, dependent: :destroy


  validates :question_id, :body, presence: true

  accepts_nested_attributes_for :attachments

  after_create :calculate_reputation

  private

  def calculate_reputation
    CalculateReputationJob.perform_later(self)
  end
end
