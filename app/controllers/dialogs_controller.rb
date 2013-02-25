class DialogsController < ApplicationController
  before_filter :authenticate_admin!
  def index
    @dialogs = Dialog.paginate(:page => params[:page], :per_page => 10).order('id DESC')
  end

  def show
    @dialog = Dialog.find(params[:id])
  end

  def new
    @dialog = Dialog.new
  end

  def create
    @dialog = Dialog.create(params[:dialog])
    if @dialog.save
      redirect_to dialog_path(@dialog)
    else
      render :action => 'new'
    end
  end

  def edit
    @dialog = Dialog.find(params[:id])
  end

  def update
    @dialog = Dialog.find(params[:id])
    if @dialog.update_attributes(params[:dialog])
      redirect_to dialog_path(@dialog)
    else
      render :action => 'edit'
    end
  end

  def destroy
    Dialog.find(params[:id]).destroy
    redirect_to dialogs_path 
  end
end
