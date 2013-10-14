class BandsController < ApplicationController
  def index
    @bands = Band.all
    render :index
  end

  def show
    @band = Band.find(params[:id])
    render :show
  end

  def new
    @band = Band.new
    render :new
  end

  def create
    @band = Band.new(params[:band])
    if @band.save
      render :show
    else
      flash[:errors] ||= []
      flash[:errors] << @band.errors.full_messages
    end
  end

  def edit

  end

  def update

  end

  def destroy

  end
end
