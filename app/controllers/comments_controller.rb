class CommentsController < ApplicationController
    # before_action :set_comment, only: %i[ show edit update destroy ]
    # before_action :authenticate_user!, except: [:index, :show]
  
    def index
      @comments = Comment.all
    end
  
    def show
        if params.key?(:user_id)
            @user = User.find(param[:user_id])
        end
        if params.key?(:article_id)
            @article = Article.find(params[:article_id])
        end
        @comment = Comment.find(params[:id])
    end
  
    def new
      if params.key?(:user_id)
        @user = User.find(params[:user_id])
      end
      @article = Article.find(params[:article_id])
      @comment = Comment.new
    end

    def edit
    end

    def create
        if params.key?(:user_id)
            @article = Article.find(params[:article_id])
            @user = User.find(params[:user_id])
            @comment = Comment.new(comment_params)
            respond_to do |format|
              if @comment.save
                format.html { redirect_to user_article_comment_url(@user, @article, @comment), notice: "Comment was successfully created." }
                format.json { render :show, status: :created, location: @comment }
              else
                format.html { render :new, status: :unprocessable_entity }
                format.json { render json: @comment.errors, status: :unprocessable_entity }
              end
            end
          else
            @article = Article.find(params[:article_id])
            @comment = Comment.new(comment_params)
      
            respond_to do |format|
              if @comment.save
                format.html { redirect_to article_comment_url(@article, @comment), notice: "Comment was successfully created." }
                format.json { render :show, status: :created, location: @comment }
              else
                format.html { render :new, status: :unprocessable_entity }
                format.json { render json: @comment.errors, status: :unprocessable_entity }
              end
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
          params.require(:comment).permit(:content, :article_id, :user_id)
        end

end
