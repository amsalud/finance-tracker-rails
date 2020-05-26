class FriendshipController < ApplicationController
  def index
    @friends = current_user.friends
  end

  def search
    if params[:friend].present?
      @friend = params[:friend]
      if @friend
        respond_to do |format|
          format.js { render partial: 'friendship/result' }
        end
      else
        respond_to do |format|
          flash.now[:alert] = "Couldn't find user"
          format.js { render partial: 'friendship/result' }
        end
      end
    else
      respond_to do |format|
        flash.now[:alert] = "Please enter a friend name or email to search"
        format.js { render partial: 'friendship/result' }
      end
    end
  end
end
