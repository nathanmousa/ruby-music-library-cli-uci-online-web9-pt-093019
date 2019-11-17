class Song
  extend Concerns::Findable
  attr_accessor :name
  @@all = []
  
  def initialize(name, artist=nil, genre=nil)
    @name = name
    self.artist = artist if artist
    self.genre = genre if genre
  end
  
  def self.all
    @@all
  end
  
  def self.create(name)
    song = Song.new(name)
    song.save
    song
  end
  
  def self.destroy_all
    @@all.clear
  end
  
  def save
    @@all << self
  end
  
  def artist
    @artist
  end
  
  def artist=(artist)
    @artist = artist if @artist == nil
    @artist.add_song(self)
  end
  
  def genre
    @genre
  end
  
  def genre=(genre)
    @genre = genre if @genre == nil
    @genre.add_song(self)
  end
  
  def self.find_by_name(song_name)
    @@all.detect do |song|
      song.name == song_name
    end
  end
  
  def self.find_or_create_by_name(name)
    self.find_by_name(name) || self.create(name)
  end
  
    def self.new_from_filename(name)
    artist_name = name.split(" - ")[0]
    song_name = name.split(" - ")[1]
    genre_name = name.split(" - ")[2].chomp(".mp3")

    song = Song.new(song_name)
    song.artist = Artist.find_or_create_by_name(artist_name)
    song.genre = Genre.find_or_create_by_name(genre_name)
    song
  end
  
  def self.create_from_filename(name)
    @@all << self.new_from_filename(name)
  end
end