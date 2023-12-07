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

      def deleteAll
        begin
          Article.transaction do
            Article.find_each(&:destroy!)
          end
          render json: { status: 'SUCCESS', message: 'Deleted all articles' }, status: :ok
        rescue => e
          render json: { status: 'ERROR', message: 'Failed to delete all articles', data: e.message }, status: :unprocessable_entity
        end
      end
    end
  end
end
