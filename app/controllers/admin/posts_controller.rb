class Admin::PostsController < ApplicationController
  def index
    @posts = Post.all
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    if @post.save
      redirect_to admin_posts_path, flash: { success: 'The post has been created.' }
    else
      render :new
    end
  end

  def edit
    @post = Post.find(params[:id])
  end

  def update
    @post = Post.find(params[:id])
    update_params = { title: post_params[:title], body: post_params[:body].gsub(/\r\n/, '<br />') }
    @post.update_attributes(update_params)
    redirect_to edit_admin_post_path(@post), flash: { success: 'The post has been updated.' }
  end

  def destroy
    @post = Post.find(params[:id])
    @post.destroy
    redirect_to admin_posts_path, flash: { success: 'The post has been deleted.' }
  end

  private

  def post_params
    params.require(:post).permit(:title, :body)
  end
end
