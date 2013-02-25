class VideosController < ApplicationController
  before_filter :check_admin_logged_in!, :except => [:show, :index, :create, :new, :update, :edit]
  before_filter :check_user_logged_in!, :only => [:show, :create, :new, :update, :edit]
 
  def admin
    @videos = Video.where(:published => true).paginate(:page => params[:page], :per_page => 10).order('id DESC')
  end

  def publish
    @videos = Video.not_published
  end
 
  def index
    if params[:category_id]
      @videos = Video.filter_by_category(params[:category_id])
    else
      @videos = Video.published.limit(200)
    end
  end

  def new
    @video = Video.new
    @categories = Category.all
  end

  def show
    @video = Video.find(params[:id])
  end

  def create
    @video = Video.create(params[:video])
    if current_user
      if verify_recaptcha(:model => @video,
                          :message => "Kod weryfikacji jest niepoprawny",
                          :attribute => "verification code") && @video.save
        redirect_to video_path(@video)
      else
        flash.delete(:recaptcha_error)
        render :action => 'new'
      end
    else
      if @video.save
        redirect_to video_path(@video)
      else
        render :action => 'new'
      end
    end
  end

  def edit
   @video = Video.find(params[:id])
  end

  def update
    @video = Video.find(params[:id])
    if current_user
      if verify_recaptcha(:model => @video,
                          :message => "Kod weryfikacji jest niepoprawny",
                          :attribute=>"verification code") && @video.update_attributes(params[:video])
        redirect_to video_path(@video)
      else
        flash.delete(:recaptcha_error)
        render :action => 'edit'
      end
    else
      if @video.update_attributes(params[:video])
        redirect_to video_path(@video) 
      else
        render :action => 'edit'
      end
    end
  end

  def destroy
    Video.find(params[:id]).destroy
    redirect_to admin_videos_path
  end

  private
    
  def check_admin_logged_in! # admin must be logged in
    authenticate_admin!
  end

  def check_user_logged_in! # if admin is not logged in, user must be logged in
    if !admin_signed_in?
      authenticate_user!
    end   
  end
end
