class Song < ActiveRecord::Base
  # add associations here
  belongs_to :artist
  belongs_to :genre
  has_many :notes
  #added this to allow the the params to be accepted
  accepts_nested_attributes_for :notes

  # This method allows us to set an artist name
  def artist_name=(name)
    # When instantiating, set the .artist attribute to what is input in name
    self.artist = Artist.find_or_create_by(name: name)

  end

# This method allows us to read the artist name in the form/controller
  def artist_name
    # Find the name of the artist associated with this specific object
    artist.try(:name)
    # This wouldn't work: WHY?
    # @artist_name= self.artist.name
  end
  # def genre_name=(name)
  #   # When the song object is created, set it's .genre attribute to what is input in the name arg
  #   self.genre = Genre.find(name: name)
  # end

  
end
