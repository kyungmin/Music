class TracksController < ApplicationController
  def index
    @tracks = Track.all
    render :index
  end

  def show
    @track = current_track
    @album = Album.find(params[:album_id])
    @band = @album.band
    @notes = current_track.notes
    render :show
  end

  def new
    @track = Track.new
    @album = Album.find(params[:album_id])
    @band = @album.band
    render :new
  end

  def create
    @track = Track.new(params[:track])
    @track.album_id = params[:album_id]
    @album = Album.find(params[:album_id])

    if @track.save
      flash[:notice] ||= []
      flash[:notice] << "Track created."
      redirect_to album_url(@album)
    else
      flash[:errors] ||= []
      flash[:errors] << @track.errors.full_messages
      redirect_to album_url(@album)
    end
  end

  def edit
    @track = current_track
    render :edit
  end

  def update
    @track = current_track
    @track.update_attributes(params[:track])
    render :show
  end

  def destroy
    @track = current_track
    if @track.delete
      flash[:notice] ||= []
      flash[:notice] << "Track deleted."
    else
      flash[:errors] ||= []
      flash[:errors] << @track.errors.full_messages
    end
    redirect_to album_url(params[:album_id])
  end

  private

  def current_track
    @current_track ||= Track.includes(:album).find(params[:id])
  end
end
