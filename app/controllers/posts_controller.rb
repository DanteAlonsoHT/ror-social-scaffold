class PostsController < ApplicationController
  before_action :authenticate_user!

  def index
    @post = Post.new
    timeline_posts
  end

  def create
    @post = current_user.posts.new(post_params)

    if @post.save
      redirect_to posts_path, notice: 'Post was successfully created.'
    else
      timeline_posts
      render :index, alert: 'Post was not created.'
    end
  end

  private

  def timeline_posts
    @friends = []
    Friendship.all.each do |single_friendship|
      if single_friendship.confirmed == true
        if single_friendship.user_id == current_user.id
          @friends.append(single_friendship.friend_id)
        elsif single_friendship.friend_id == current_user.id
          @friends.append(single_friendship.user_id)
        end
      end
    end
    @friends.append(current_user.id)
    @timeline_posts = Post.where(user_id: @friends).ordered_by_most_recent
  end

  def post_params
    params.require(:post).permit(:content)
  end
end
