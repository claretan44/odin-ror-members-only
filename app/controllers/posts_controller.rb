class PostsController < ApplicationController
  before_action :authenticate_user!, only: [ :create, :new ]
  def index
    @posts=Post.all
  end
  def new
    @post=Post.new
  end
  def create
    @post = Post.new(allowed_post_params.merge(user: current_user))
    if @post.save
      redirect_to posts_path
    else
      render :new, status: :unprocessable_entity
    end
  end

  private
  def allowed_post_params
    params.expect(post: [ :title, :content ])
  end
end
