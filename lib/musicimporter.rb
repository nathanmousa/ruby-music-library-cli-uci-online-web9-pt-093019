class MusicImporter
  attr_reader :path
  
  def initialize(path)
    @path = path
  end

  def path
    @path
  end

  def files()
    @files ||= Dir.glob("#{@path}/*.mp3").collect{ |file| file.gsub("#{@path}/", "") }
  end

  def import()
    files.each do |name|
      Song.create_from_filename(name)
    end
  end

end