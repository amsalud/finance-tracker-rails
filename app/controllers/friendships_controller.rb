class FriendshipsController < ApplicationController
  def index
    @friends = current_user.friends
  end

  def create
    friend = User.find(params[:friend])
    if current_user.friends << friend
      flash[:notice] = "You are now following #{friend.first_name} #{friend.last_name}"
    else
      flash[:alert] = "There is something wrong please contact admin"
    end
    redirect_to friends_path
  end

  def destroy
    friendship = current_user.friendships.where(friend_id: params[:id]).first
    friendship.destroy
    flash[:notice] = "Friend has been unfollowed"
    redirect_to friends_path
  end

  def search
    if params[:friend].present?
      @friends = User.search(params[:friend])
      @friends = current_user.except_current_user(@friends)
      if @friends
        respond_to do |format|
          format.js { render partial: 'friendships/result' }
        end
      else
        respond_to do |format|
          flash.now[:alert] = "Couldn't find user"
          format.js { render partial: 'friendships/result' }
        end
      end
    else
      respond_to do |format|
        flash.now[:alert] = "Please enter a friend name or email to search"
        format.js { render partial: 'friendships/result' }
      end
    end
  end
end
