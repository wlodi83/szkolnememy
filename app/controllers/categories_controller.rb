class CategoriesController < ApplicationController
  before_filter :authenticate_admin!
  def index
    @categories = Category.all
  end

  def show
    @category = Category.find(params[:id])
  end

  def new
    @category = Category.new
  end

  def create
    @category = Category.create(params[:category])
    if @category.save
      redirect_to category_path(@category)
    else
      render :action => 'new'
    end
  end

  def update
    @category = Category.find(params[:id])
    if @category.update_attributes(params[:category])
      redirect_to category_path(@category)
    else
      render :action => 'edit'
    end
  end

  def edit
    @category = Category.find(params[:id])
  end

  def destroy
    Category.find(params[:id]).destroy
    redirect_to categories_path
  end
end
