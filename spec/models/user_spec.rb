require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user1) { User.create!(name: 'test', email: 'test@test.com', password: '123456', encrypted_password: '123456') }
  let(:user2) { User.create!(name: 'test2', email: 'test2@test.com', password: '123456', encrypted_password: '123456') }

  context 'Assosiations' do
    it { should have_many(:sent_friend_requests) }
    it { should have_many(:recieved_friend_requests) }
    it { should have_many(:friendships) }
    it { should have_many(:friends) }
  end

  context 'Sending Request' do
    it 'should send friend request' do
      user1.sent_friend_requests.create(friend_id: user2.id)
      expect(user2.recieved_friend_requests.find_by(user_id: user1.id)).to_not be_nil
    end
  end

  context 'Instance Methods to Query Data' do
    describe 'check_request_existence' do
      it 'should check if users are friends' do
        user1.friendships.create(friend_id: user2.id)
        expect(user1.check_request_existence(user2)).to eql(true)
      end

      it 'should check if sent_friend_requests exists' do
        user1.friendships.create(friend_id: user2.id)
        expect(user1.check_request_existence(user2)).to eql(true)
      end

      it 'should check if recieved_friend_requests exists' do
        user1.friendships.create(friend_id: user2.id)
        expect(user1.check_request_existence(user2)).to eql(true)
      end
    end

  end
end
