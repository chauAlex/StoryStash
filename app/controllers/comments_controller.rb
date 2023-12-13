class CommentsController < ApplicationController
    before_action :set_comment, only: %i[ show edit destroy ]
    before_action :authenticate_user!, except: [:index, :show]
  
    def index
      @comments = Comment.includes(:user)
    end
  
    def show
      @article = Article.find(params[:article_id])
      @comment = @article.comments
    end
  
    def new
      @article = Article.find(params[:article_id])
      @comment = Comment.new
    end

    def edit
    end

    def create
      @article = Article.find(params[:article_id])
      @comment = Comment.new(comment_params)
      @comment.user = current_user
  
      respond_to do |format|
        if @comment.save
          format.html { redirect_to article_url(@article), notice: "Comment was successfully created." }
          format.json { render :show, status: :created, location: @comment }
        else
          format.html { render :new, status: :unprocessable_entity }
          format.json { render json: @comment.errors, status: :unprocessable_entity }
        end
      end
    end

    def destroy
        @comment.destroy!
    
        respond_to do |format|
          format.html { redirect_to comments_url, notice: "Comment was successfully destroyed." }
          format.json { head :no_content }
        end
      end
    
      private
        def set_comment
          @comment = Comment.find(params[:id])
        end
    
        def comment_params
          params.require(:comment).permit(:content, :article_id)
        end

end
