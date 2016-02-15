require 'rails_helper'

RSpec.describe Vote, type: :model do

  it { should belong_to :user }
  it { should belong_to :votable }

  describe 'reputation' do
    it 'calculate reputaton after create' do
      expect(Reputation).to receive(:calculate).with(subject)
      subject.save!
    end

    it 'does not calculate reputation after update' do
      subject.save!
      expect(Reputation).to_not receive(:calculate)
      subject.update!(value: 1)
    end

  end
end