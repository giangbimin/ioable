class AuthorsController < ApplicationController
  def show
    @author = User.find(params[:id])
    @articles = Article.where(user_id: @author.id).order('created_at DESC')
                       .page(params[:page]).per(5)
    @count = Article.where(user_id: @author.id).count
  end

  def index
    @authors = User.all
  end
end
