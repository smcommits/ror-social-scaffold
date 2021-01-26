class FriendRequestsController < ApplicationController
  def create
    @request = current_user.sent_friend_requests.build(friend_id: params[:id])
    if @request.save
      flash[:success] = 'Friend Request Sent!'
    else
      flash[:alert] = 'Something Went Wrong!'
    end
    redirect_to users_path
  end

  def destroy
    @request = FriendRequest.find(params[:id])
    flash[:alert] = if @request.destroy
                      'Request Rejected'
                    else
                      'Something went wrong!'
                    end
    redirect_to users_path
  end
end
