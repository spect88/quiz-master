require 'rails_helper'

describe User do
  describe '#name' do
    let(:user) do
      User.new(info: { 'name' => 'John Doe' })
    end

    it 'is retrieved from the info hash' do
      expect(user.name).to eq('John Doe')
    end
  end

  describe '.from_auth_hash' do
    let(:auth_hash) do
      OmniAuth::AuthHash.new(
        provider: 'auth0',
        uid: 'auth0|58c03b0a61d8c359422f85ce',
        info: { name: 'John Doe', email: 'john@example.org' }
      )
    end

    context 'when user already exists' do
      let!(:existing_user) do
        described_class.create!(
          provider: 'auth0',
          uid: 'auth0|58c03b0a61d8c359422f85ce',
          info: auth_hash.info.to_h
        )
      end

      it 'returns existing user' do
        user = described_class.from_auth_hash(auth_hash)
        expect(user).to be_persisted
        expect(user).to eq(existing_user)
        expect(user).not_to be_changed
      end
    end

    context 'when such user doesn\'t exist' do
      it 'initializes new user' do
        user = described_class.from_auth_hash(auth_hash)
        expect(user).not_to be_persisted
      end
    end
  end
end
