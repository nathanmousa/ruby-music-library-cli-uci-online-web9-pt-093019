class MusicLibraryController
  extend Concerns::Findable

  def initialize(path="./db/mp3s")
    obj = MusicImporter.new(path)
    obj.import
  end

  def call
    input = ""
    while input != "exit"
      puts "Welcome to your music library!"
      puts "To list all of your songs, enter 'list songs'."
      puts "To list all of the artists in your library, enter 'list artists'."
      puts "To list all of the genres in your library, enter 'list genres'."
      puts "To list all of the songs by a particular artist, enter 'list artist'."
      puts "To list all of the songs of a particular genre, enter 'list genre'."
      puts "To play a song, enter 'play song'."
      puts "To quit, type 'exit'."
      puts "What would you like to do?"
      input = gets.strip

      if input == "list songs"
        list_songs
      elsif input == "list artists"
        list_artists
      elsif input == "list genres"
        list_genres
      elsif input == "list artist"
        list_songs_by_artist
      elsif input == "list genre"
        list_songs_by_genre
      elsif input == "play song"
        play_song
      end
    end
  end

  def list_songs
    sorted_songs = Song.all.sort_by do |song|
      song.name
    end
    
    sorted_songs.each.with_index(1) do |song, i|
      puts "#{i}. #{song.artist.name} - #{song.name} - #{song.genre.name}"
    end
  end

  def list_artists
    sorted_artists = Artist.all.sort_by do |artist|
      artist.name
    end
    
    sorted_artists.each.with_index(1) do |artist, i|
      puts "#{i}. #{artist.name}"
    end
  end

  def list_genres
    sorted_genres = Genre.all.sort_by do |genre|
      genre.name
    end
    
    sorted_genres.each.with_index(1) do |genre, i|
      puts "#{i}. #{genre.name}"
    end
  end

  def list_songs_by_artist
    puts "Please enter the name of an artist:"
    input = gets.chomp
    
    if artist = Artist.find_by_name(input)
      sorted_songs = artist.songs.sort_by do |song|
        song.name
      end

      sorted_songs.each.with_index(1) do |song, i|
        puts "#{i}. #{song.name} - #{song.genre.name}"
      end
    end
  end

  def list_songs_by_genre
    puts "Please enter the name of a genre:"
    input = gets.chomp
    
    if genre = Genre.find_by_name(input)
      sorted_genres = genre.songs.sort_by do |song|
        song.name
      end
      
      sorted_genres.each.with_index(1) do |song, i|
        puts "#{i}. #{song.artist.name} - #{song.name}"
      end
    end
  end

  def play_song
    puts "Which song number would you like to play?"
    list =  Song.all.sort{ |a, b| a.name <=> b.name }
    
    input = gets.strip.to_i
    if input > 0 && input <= list.length
      playing = list[input - 1]
      puts "Playing #{playing.name} by #{playing.artist.name}"
    end
  end
  
end