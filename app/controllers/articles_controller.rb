class ArticlesController < ApplicationController
  skip_before_action :verify_authenticity_token
  before_action :authenticate_user!, except: [:index, :show]
  before_action :set_article, only: [:show, :edit, :update, :destroy]
  before_action :popular_articles, only: [:index, :show]
  # GET /articles
  # GET /articles.json
  def index
    if !params[:term].blank?
      @articles = Article.search_for(params[:term])
                         .order('created_at DESC').page(params[:page]).per(5)
      @count = Article.search_for(params[:term]).count
    else
      @articles = Article.all.order('created_at DESC')
                         .page(params[:page]).per(5)
      @count = Article.count
    end
  end

  # GET /articles/1
  # GET /articles/1.json
  def show
    @comments = @article.comments.order('created_at DESC')
    @article.trackers.create({ guess_ip: request.remote_ip.to_s })
    @article.update(view: @article.trackers.pluck(:guess_ip).length)
    # @article.update(view: @article.trackers.pluck(:guess_ip).uniq.length)
  end

  # GET /articles/new
  def new
    @article = current_user.articles.build
  end

  # GET /articles/1/edit
  def edit
  end

  # POST /articles
  # POST /articles.json
  def create
    @article = current_user.articles.build(article_params)

    respond_to do |format|
      if @article.save
        format.html { redirect_to @article, notice: 'Article was successfully created.' }
        format.json { render :show, status: :created, location: @article }
      else
        format.html { render :new }
        format.json { render json: @article.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /articles/1
  # PATCH/PUT /articles/1.json
  def update
    respond_to do |format|
      if author?
        if @article.update(article_params)
          format.html { redirect_to @article, notice: 'Article was successfully updated.' }
          format.json { render :show, status: :ok, location: @article }
        else
          format.html { render :edit }
          format.json { render json: @article.errors, status: :unprocessable_entity }
        end
      else
        format.html { redirect_to articles_url, notice: 'You are not author' }
      end
    end
  end

  # DELETE /articles/1
  # DELETE /articles/1.json
  def destroy
    if author?
      @article.destroy
      respond_to do |format|
        format.html { redirect_to articles_url, notice: 'Article was successfully destroyed.' }
        format.json { head :no_content }
      end
    else
      respond_to do |format|
        format.html { redirect_to articles_url, notice: 'You are not author' }
      end
    end
  end

  private

  def author?
    @article.user == current_user
  end

  # Use callbacks to share common setup or constraints between actions.
  def set_article
    @article = Article.friendly.find(params[:id])
  end

  def popular_articles
    @popular_articles = Article.all.order(view: :desc).limit(5)
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def article_params
    params.require(:article).permit(:title, :body, :description,
                                    :tag_list, :picture, :remove_picture)
  end
end
