require 'rails_helper'

RSpec.describe 'Friendships', type: :request do
  let(:user1) { User.create!(name: 'test', email: 'test@test.com', password: '123456', encrypted_password: '123456') }
  let(:user2) { User.create!(name: 'test2', email: 'test2@test.com', password: '123456', encrypted_password: '123456') }

  describe 'POST /create' do
    context 'Valid Data'
    it 'create two friendship records with transaction' do
      expect do
        post friendships_url, params: { id: 200 }
      end.to change(Friendship, :count).by(0)
    end
  end
end
