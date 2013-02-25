class UsersController < ApplicationController
  before_filter :authenticate_admin!
  def index
    @users = User.paginate(:page => params[:page], :per_page => 10).order('id DESC')
  end

  def destroy
    User.find(params[:id]).destroy
    redirect_to users_path
  end
end
