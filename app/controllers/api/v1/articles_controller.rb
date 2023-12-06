# app/controllers/api/v1/articles_controller.rb
module Api
  module V1
    class ArticlesController < ApplicationController
      skip_before_action :verify_authenticity_token

      def destroy
        @article = Article.find(params[:id])
        if @article.destroy
          render json: { status: 'SUCCESS', message: 'Deleted article', data: @article }, status: :ok
        else
          render json: { status: 'ERROR', message: 'Article not deleted', data: @article.errors }, status: :unprocessable_entity
        end
      end
    end
  end
end
