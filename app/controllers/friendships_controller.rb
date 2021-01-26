class FriendshipsController < ApplicationController
  def create
    friend = User.find(params[:id])

    User.transaction do
      current_user.friendships.create!(friend_id: friend.id)
      friend.friendships.create!(friend_id: current_user.id)
    end

    RequestDestroyer.call(friend_id: friend.id, user_id: current_user.id)

    flash[:notice] = "Congratulation! You are now friends with #{friend.name}"
    redirect_to users_path
  rescue StandardError
    flash[:alert] = 'Something went wrong!'
    redirect_to users_path
  end
end
