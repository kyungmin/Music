class NotesController < ApplicationController
  def create
    @note = Note.new(params[:note])
    @note.user_id = current_user.id
    @note.track_id = new_track.id
    if @note.save
      flash[:notice] ||= []
      flash[:notice] << "Note created."
#      render "tracks/show"
      redirect_to album_track_url(new_track.album, new_track)
    else
      flash[:errors] ||= []
      flash[:errors] << @note.errors.full_messages
#      render "tracks/show"
      redirect_to album_track_url(new_track.album, new_track)
    end
  end

  def destroy
    @note = current_note

    if @note.delete
      flash[:notice] ||= []
      flash[:notice] << "Note deleted."
      redirect_to album_track_url(current_track.album, current_track)
    else
      flash[:errors] ||= []
      flash[:errors] << @note.errors.full_messages
      redirect_to album_track_url(current_track.album, current_track)
    end

  end

  private

  def new_track
    @new_track ||= Track.find(params[:note][:track_id])
  end

  def current_track
    @current_track ||= current_note.track
  end

  def current_note
    @current_note ||= Note.find(params[:id])
  end
end
