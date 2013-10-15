class AlbumsController < ApplicationController
  def index
    @albums = Album.all
    render :index
  end

  def show
    @band = current_album.band
    @album = current_album
    @tracks = current_album.tracks
    render :show
  end

  def new
    @bands = Band.all
    @band = Band.find(params[:band_id])
    @album = Album.new
    render :new
  end

  def create
    @album = Album.new(params[:album])
    @band = Band.find(params[:band_id])
    if @album.save
      redirect_to band_url(@band)
    else
      flash[:errors] ||= []
      flash[:errors] << @album.errors.full_messages
      redirect_to band_url(@band)
    end
  end

  def edit
    @album = current_album
    render :edit
  end

  def update
    @album = current_album
    @album.update_attributes(params[:album])
    render :show
  end

  def destroy
    @album = current_album
    if @album.delete
      flash[:notice] ||= []
      flash[:notice] << "Album deleted."
    else
      flash[:errors] ||= []
      flash[:errors] << @album.errors.full_messages
    end
    redirect_to band_url(params[:band_id])
  end

  private

  def current_album
    @current_album ||= Album.includes(:band).find(params[:id])
  end
end
