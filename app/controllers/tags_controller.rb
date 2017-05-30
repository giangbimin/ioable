class TagsController < ApplicationController
  def show
    @tag = params[:id]
    @articles = Article.tagged_with(params[:id]).order('created_at DESC')
                       .page(params[:page]).per(5)
  end
end
