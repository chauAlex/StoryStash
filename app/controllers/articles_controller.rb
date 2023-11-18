class ArticlesController < ApplicationController
  before_action :set_article, only: %i[ show edit update destroy ]
  before_action :authenticate_user!, except: [:index, :show]

  def like
    @article = Article.find(params[:id])
    @like = current_user.likes.build(article_id: params[:id])
    if @like.save
      redirect_to @article, notice: 'You liked this article!'
    else
      redirect_to @article, notice: 'Error liking post.'
    end
  end

  def unlike
    @article = Article.find(params[:id])
    @like = current_user.likes.find_by(article_id: params[:id])
    @like.destroy if @like
    redirect_to @article, notice: 'You unliked this article!'
  end

  # GET /articles or /articles.json
  def index
    session[:sort] = params[:sort] if params[:sort].present?
    @articles = case session[:sort]
    when 'likes'
      Article.order(likes_count: :desc)
    when 'latest'
      Article.order(created_at: :desc)
    else
      Article.all
    end
  end

  # GET /articles/1 or /articles/1.json
  def show
  end

  # GET /articles/new
  def new
    @article = Article.new
  end

  # GET /articles/1/edit
  def edit
  end

  # POST /articles or /articles.json
  def create
    params[:article][:user_id] = current_user.id if params[:article][:user_id].nil?
    @article = Article.new(article_params)

    respond_to do |format|
      if @article.save
        format.html { redirect_to article_url(@article), notice: "Article was successfully created." }
        format.json { render :show, status: :created, location: @article }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @article.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /articles/1 or /articles/1.json
  def update
    respond_to do |format|
      params[:article][:user_id] = current_user.id if params[:article][:user_id].nil?
      if @article.update(article_params)
        format.html { redirect_to article_url(@article), notice: "Article was successfully updated." }
        format.json { render :show, status: :ok, location: @article }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @article.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /articles/1 or /articles/1.json
  def destroy
    @article.destroy!

    respond_to do |format|
      format.html { redirect_to articles_url, notice: "Article was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_article
      @article = Article.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def article_params
      params.require(:article).permit(:title, :content, :user_id, :price)
    end
end
