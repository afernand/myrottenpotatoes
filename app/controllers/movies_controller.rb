class MoviesController < ApplicationController

  def show
    id = params[:id] # retrieve movie ID from URI route
    @movie = Movie.find(id) # look up movie by unique ID
    # will render app/views/movies/show.<extension> by default
  end

  def index
    # if params['sort_by_title'] exists, then sort by title
    @title_class = {:class=>'normal'};
    @release_date_class = {:class=>'normal'};
    if params[:sort_by_title]
      @movies = Movie.order('title')
      @title_class = {:class=>'hilite'};
    else 
      if params[:sort_by_release_date]
        @movies = Movie.order('release_date')
        @release_date_class = {:class=>'hilite'};
      else
        @movies = Movie.all
      end
    end
    
  end

  def new
    # default: render 'new' template
  end

  def create
    @movie = Movie.create!(params[:movie])
    flash[:notice] = "#{@movie.title} was successfully created."
    redirect_to movies_path
  end

  def edit
    @movie = Movie.find params[:id]
  end

  def update
    @movie = Movie.find params[:id]
    @movie.update_attributes!(params[:movie])
    flash[:notice] = "#{@movie.title} was successfully updated."
    redirect_to movie_path(@movie)
  end

  def destroy
    @movie = Movie.find(params[:id])
    @movie.destroy
    flash[:notice] = "Movie '#{@movie.title}' deleted."
    redirect_to movies_path
  end

end
