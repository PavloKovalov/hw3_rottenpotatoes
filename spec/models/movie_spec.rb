require 'spec_helper'

describe Movie do
  #fixtures :movies
  
  before :each do
    movies = [
      {:title => "Star Wars", :rating => "PG", :director => "George Lucas", :release_date => "1977-05-25"},
      {:title => "Blade Runner", :rating => "PG", :director => "Ridley Scott", :release_date => "1982-06-25"},
      {:title => "Alien", :rating => "R", :director => "", :release_date => "1979-05-25" },
      {:title => "THX-1138", :rating => "R", :director => "George Lucas", :release_date => "1971-03-11"}
    ]
    movies.each do |movie|
      Movie.create!(movie)
    end
  end
  it 'should find movies with same director attribute' do
    Movie.findsimilar(1).should == [Movie.find(4)]
  end

  it 'should raise an EmptyDirectorError with no director' do
    lambda {Movie.findsimilar(3)}.should raise_error(Movie::EmptyDirectorError)
  end

  it 'should return nil if no similar movies found' do
    Movie.findsimilar(2).should == []
  end 

end