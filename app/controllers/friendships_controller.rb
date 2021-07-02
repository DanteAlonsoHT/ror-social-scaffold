class FriendshipsController < ApplicationController
  def create
    @friendship = current_user.friendships.new(friend_id: params[:user_id])

    if @friendship.save
      redirect_to users_path, notice: "You've invited #{@friendship.friend.name}!"
    else
      redirect_to users_path, alert: 'Upps! but you cannot invite this friend.'
    end
  end

  def update
    friend = User.find(params[:user_id])
    current_user.confirm_friend(friend)

    redirect_to user_path(current_user), notice: "#{friend.name} and you are already friends!"
  end

  def destroy
    friendship = Friendship.find(params[:id])
    friend = friendship.user
    current_user.reject_friend(friend)

    redirect_to user_path(current_user), notice: "You've rejected #{friend.name} :("
  end
end
