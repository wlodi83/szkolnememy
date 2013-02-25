class MemesController < ApplicationController
  before_filter :check_admin_logged_in!, :except => [:show, :index, :create, :new, :update, :edit]
  before_filter :check_user_logged_in!, :only => [:show, :create, :new, :update, :edit]
 
  def admin
    @memes = Meme.where(:published => true).paginate(:page => params[:page], :per_page => 10).order('id DESC')
  end

  def publish
    @memes = Meme.not_published
  end
 
  def index
    if params[:category_id]
      @memes = Meme.filter_by_category(params[:category_id])
    else
      @memes = Meme.published.limit(200)
    end
  end

  def new
    @meme = Meme.new
    @categories = Category.all
  end

  def show
    @meme = Meme.find(params[:id])
  end

  def create
    @meme = Meme.create(params[:meme])
    if current_user
      if verify_recaptcha(:model => @meme,
                          :message => "Kod weryfikacji jest niepoprawny",
                          :attribute => "verification code") && @meme.save
        redirect_to meme_path(@meme)
      else
        flash.delete(:recaptcha_error)
        render :action => 'new'
      end
    else
      if @meme.save
        redirect_to meme_path(@meme)
      else
        render :action => 'new'
      end
    end
  end

  def edit
   @meme = Meme.find(params[:id])
  end

  def update
    @meme = Meme.find(params[:id])
    if current_user
      if verify_recaptcha(:model => @meme,
                          :message => "Kod weryfikacji jest niepoprawny",
                          :attribute=>"verification code") && @meme.update_attributes(params[:meme])
        redirect_to meme_path(@meme)
      else
        flash.delete(:recaptcha_error)
        render :action => 'edit'
      end
    else
      if @meme.update_attributes(params[:meme])
        redirect_to meme_path(@meme) 
      else
        render :action => 'edit'
      end
    end
  end

  def destroy
    Meme.find(params[:id]).destroy
    redirect_to admin_memes_path
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
