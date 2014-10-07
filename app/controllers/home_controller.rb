class HomeController < ApplicationController
  def index
    @posts = Post.all
  end

  def about
    @staff = Staff.all
  end
end
