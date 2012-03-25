class Movie < ActiveRecord::Base

  class Movie::MovieError < StandardError ; end
  class Movie::EmptyDirectorError < MovieError ; end

  def self.all_ratings
    %w(G PG PG-13 NC-17 R)
  end

  def self.findsimilar(id)
  	begin
  		movie=self.find(id)
  	rescue StandardError => error
  		raise Movie::MovieError, error
  	end
  	
  	if (movie.director =~ /^(.+)$/)
  		movies = self.find(:all, :conditions => ['director = ? AND id != ?', movie.director, movie.id])
  	else
  		raise Movie::EmptyDirectorError, %Q{Movie #{movie.title} has empty director attribute}
  	end
  	
  end
end
