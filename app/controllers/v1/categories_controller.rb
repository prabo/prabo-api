module V1
  class CategoriesController < ApplicationController

    # GET
    # Show all categories
    def index
      @categories = Category.all
      render json: @categories, each_serializer: V1::CategorySerializer, root: nil
    end

    # POST
    # Create an category
    def create
      if Category.exists?(:name => category_params[:name])
        return render json: { error: 'そのカテゴリー名は使われています。' }, status: 400
      end
      @category = Category.new category_params

      if @category.save!
        render json: @category, serializer: V1::CategorySerializer, root: nil
      else
        render json: {error: 'カテゴリーを作成できませんでした。'}, status: :unprocessable_entity
      end
    end

    # DELETE
    # delete an category
    def destroy
      @category = Category.find(params[:id])
      if !@category.nil?
        render json: {error: 'そのカテゴリーは存在しません。'}, status: :unprocessable_entity
      elsif @category.destroy!
        render json: @category, serializer: V1::CategorySerializer, root: nil
      else
        render json: {error: 'カテゴリーを削除できませんでした。'}, status: :unprocessable_entity
      end
    end

    # PUT
    # update an category
    def update
      @category = Category.find(params[:id])
      if !@category.nil? and @category.update category_params
        render json: @category, serializer: V1::CategorySerializer, root: nil
      else
        render json: {error: 'カテゴリーを変更することが出来ませんでした'}, status: :unprocessable_entity
      end
    end

    # GET
    # Show an category
    def show
      @category = Category.find(params[:id])
      render json: @category, serializer: V1::CategorySerializer, root: nil
    end

    def render_404
      render json: {error: 'カテゴリーが見つかりません。'}, status: 404
    end

    private

    def category_params
      @category_params || params.permit(:name)
    end
  end
end
