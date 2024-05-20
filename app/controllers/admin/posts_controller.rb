class Admin::PostsController < ApplicationController
  before_action :authenticate_admin!

  def index
    @q = Post.ransack(params[:q])
    @posts = @q.result.page(params[:page]).per(10)
  end

  private

  def authenticate_admin!
    redirect_to root_path unless current_user&.admin?
  end
end
