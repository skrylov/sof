require 'rails_helper'

RSpec.describe User do
  it { should validate_presence_of :email}
  it { should validate_presence_of :password}

  describe '.find_for_oauth' do
    context 'user already has authorized' do
      let!(:user) { create(:user) }
      let(:auth) { OmniAuth::AuthHash.new(provider: 'provider', uid: '12345678') }
      it 'returns the user' do
        user.authorizations.create(provider: 'provider', uid: '12345678')
        expect(User.find_for_oauth(auth)).to eq user
      end
    end

    context 'user email already exists' do
      let!(:user) { create(:user) }
      let(:auth) { OmniAuth::AuthHash.new(provider: 'provider', uid: '12345678', info: { email: user.email }) }

      it 'does not create new user' do
        expect { User.find_for_oauth(auth) }.to_not change(User, :count)
      end

      it 'returns user' do
        expect(User.find_for_oauth(auth)).to eq user
      end

      it 'creates authorizations for user' do
        expect { User.find_for_oauth(auth) }.to change(user.authorizations, :count).by(1)
      end

      it 'saves provider and uid in authorization' do
        authorization = User.find_for_oauth(auth).authorizations.first

        expect(authorization.provider).to eq 'provider'
        expect(authorization.uid).to eq '12345678'
      end
    end

    context 'user email does not exist' do
      let(:auth) { OmniAuth::AuthHash.new(provider: 'provider',
                                          uid: '12345678', info: { email: 'new@user.com' }) }

      it 'creates new user' do
        expect { User.find_for_oauth(auth) }.to change(User, :count).by(1)
      end

      it 'returns new user' do
        expect(User.find_for_oauth(auth)).to be_a(User)
      end

      it 'fills user email' do
        user = User.find_for_oauth(auth)
        expect(user.email).to eq auth.info[:email]
      end

      it 'creates authorization for user' do
        user = User.find_for_oauth(auth)
        expect(user.authorizations).to_not be_empty
      end

      it 'saves provider and uid in authorization' do
        authorization = User.find_for_oauth(auth).authorizations.first

        expect(authorization.provider).to eq 'provider'
        expect(authorization.uid).to eq '12345678'
      end

    end
  end
end