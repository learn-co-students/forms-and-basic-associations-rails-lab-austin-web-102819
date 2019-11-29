class SongsController < ApplicationController
  def index
    @songs = Song.all
  end

  def show
    @song = Song.find(params[:id])
  end

  def new
    @song = Song.new
    # Build 3 "empty" notes that are automatically set up with the correct
    # parameter names to be used by accepts_nested_attributes_for
    # See:
    # https://api.rubyonrails.org/v5.2.3/classes/ActionView/Helpers/FormHelper.html#method-i-fields_for
    3.times { @song.notes.build }
  end

  def create
    # Create a local variable and set it equal to 
      # look for an artist that is entered into the song params with the :artist_name key
        # If one exists, set it equal to artist
        # If none exists, create it and set it equal to artist
    artist= Artist.find_or_create_by(name: song_params[:artist_name])

    # Create an instance variable and set it equal to
      # build (not create: we're not saving to the DB yet) a new Song object
        # and save the artist_id (above) to the song, using the parameters
    @song = artist.songs.build(song_params)
    # byebug
    
    # if an exception is not thrown when we save @song to the db, redirect to the @song path
    if @song.save
      redirect_to @song
    else
      #otherwise, re-render the form 
      render :new
    end
  end

  def edit
    @song = Song.find(params[:id])
  end

  def update
    @song = Song.find(params[:id])

    @song.update(song_params)

    if @song.save
      redirect_to @song
    else
      render :edit
    end
  end

  def destroy
    @song = Song.find(params[:id])
    @song.destroy
    flash[:notice] = "Song deleted."
    redirect_to songs_path
  end

  private

  def song_params
    params.require(:song).permit(:title, :artist_name, :genre_id, :notes, notes_attributes: [:content] )
    # notes_attributes is used with fields_for to nest the data
  end
end

