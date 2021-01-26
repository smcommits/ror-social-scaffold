module UsersHelper
  def display_invitation(user: nil)
    return if user == current_user

    return 'You are friends' if current_user.friends.include?(user)

    unless current_user.check_request_existence(user)
      return link_to 'Send Friend Request', friend_requests_path(id: user.id), method: :post
    end

    sent_friend_requests = current_user.sent_friend_requests.find_by(friend_id: user.id)
    'Request already sent' if sent_friend_requests
  end

  def display_pending_requests(user)
    render 'users/pending', locals: { user: user } if user == current_user
  end

  def display_accept_reject(user: nil)
    recieved_friend_request = current_user.recieved_friend_requests.find_by(user_id: user.id)
    return unless recieved_friend_request

    [link_to('Accept Friend Request', friendships_path(id: user.id), method: :post),
     link_to('Reject Friend Request', friend_request_path(id: recieved_friend_request.id), method: :delete)]
  end
end
