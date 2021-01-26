class RequestDestroyer < ApplicationService
  attr_reader :request

  def initialize(friend_id: nil, user_id: nil)
    @request = FriendRequest.find_by(user_id: friend_id, friend_id: user_id)
  end

  def call
    @request.destroy
  end
end
