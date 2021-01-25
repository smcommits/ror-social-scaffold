class FriendRequestsController < ApplicationController

  def create
    @request = current_user.sent_friend_requests.build(friend_id: params[:id])
    if @request.save
      flash[:success] = "Friend Request Sent!"
      redirect_to users_path
    else
      flash[:alert] = "Something Went Wrong!"
      redirect_to users_path
    end
  end

  def destroy 
    @request = FriendRequest.find(params[:id])
    if @request.destroy
      flash[:alert] = "Request Rejected"
      redirect_to users_path
    end
  end
end
