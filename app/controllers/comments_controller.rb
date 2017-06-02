class CommentsController < ApplicationController
  before_action :find_article
  before_action :find_comment, only: [:destroy, :update, :edit]
  before_action :author?, only: [:destroy, :edit, :update]

  def create
    @comment = @article.comments.create(comment_params)
    @comment.user_id = current_user.id
    if @comment.save
      respond_to do |format|
        format.html { redirect_to @article }
        format.js
      end
    else
      render 'new'
    end
  end

  def destroy
    @comment.destroy
    respond_to do |format|
      format.html { redirect_to article_path(@article), notice: 'comments was successfully destroyed.' }
      format.js
    end
  end

  def update
    if @comment.update(comment_params)
      respond_to do |format|
        format.html { redirect_to article_path(@article), notice: 'comments was successfully destroyed.' }
      end
    else
      render 'edit'
      flash.now[:danger] = 'error'
    end
  end

  def new; end

  def edit; end

  private

  def author?
    unless @comment.user == current_user
      respond_to do |format|
        format.html { redirect_to @article, notice: 'You are not author' }
      end
    end
  end

  def find_article
    @article = Article.friendly.find(params[:article_id])
  end

  def find_comment
    @comment = @article.comments.find(params[:id])
  end

  def comment_params
    params.require(:comment).permit(:body)
  end
end
