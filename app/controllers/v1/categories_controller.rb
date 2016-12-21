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
      @category = Category.new category_params

      if @category.save!
        render json: @category, serializer: V1::CategorySerializer, root: nil
      else
        render json: {error: t('message.category_create_error')}, status: :unprocessable_entity
      end
    end

    # DELETE
    # delete an category
    def destroy
      @category = Category.find(params[:id])
      if !@category.nil? and @category.destroy!
        render json: @category, serializer: V1::CategorySerializer, root: nil
      else
        render json: {error: t('message.category_create_error')}, status: :unprocessable_entity
      end
    end

    # PUT
    # update an category
    def update
      @category = Category.find(params[:id])
      if !@category.nil? and @category.update category_params
        render json: @category, serializer: V1::CategorySerializer, root: nil
      else
        render json: {error: t('message.category_update_error')}, status: :unprocessable_entity
      end
    end

    # GET
    # Show an category
    def show
      @category = Category.find(params[:id])
      render json: @category, serializer: V1::CategorySerializer, root: nil
    end

    private

    def category_params
      @category_params || params.permit(:name)
    end
  end
end
