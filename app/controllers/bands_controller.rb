class BandsController < ApplicationController
  def index
    @bands = Band.all
    render :index
  end

  def show
    @band = current_band
    @albums = current_band.albums
    render :show
  end

  def new
    @band = Band.new
    render :new
  end

  def create
    @band = Band.new(params[:band])
    if @band.save
      redirect_to band_url(@band)
    else
      flash[:errors] ||= []
      flash[:errors] << @band.errors.full_messages
      redirect_to band_url(@band)
    end
  end

  def edit
    @band = current_band
    render :edit
  end

  def update
    @band = current_band
    @band.update_attributes(params[:band])
    render :show
  end

  def destroy
    @band = current_band
    if @band.delete
      flash[:notice] ||= []
      flash[:notice] << "Band deleted."
    else
      flash[:errors] ||= []
      flash[:errors] << @band.errors.full_messages
    end
    redirect_to bands_url
  end

  private

  def current_band
    @current_band ||= Band.includes(:albums).find(params[:id])
  end
end
