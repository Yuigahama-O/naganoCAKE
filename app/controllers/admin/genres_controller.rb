class Admin::GenresController < ApplicationController
    before_action :authenticate_admin!, except: [:top,:about]

  def index
    @genre = Genre.new
    @genres = Genre.all
  end

  def edit
    @genre = Genre.find(params[:id])
  end
  
  def create
    @genres = Genre.new(genres_params)
    @genres.save
    redirect_to admin_genres_path
  end
  
  def update
    @genre = Genre.find(params[:id])
    @genre.update(genres_params)
    redirect_to admin_genres_path
  end
  
  private
  def genres_params
    params.require(:genre).permit(:genre)
  end
end
