require 'spec_helper'

describe MoviesController do
  describe 'find similar movies' do
  	before :each do
  		@fake_results = [mock(Movie), mock(Movie)]
  		@id = "1"
  	end

    it 'should call the model method that performs similar movies search' do
    	Movie.should_receive(:findsimilar).with(@id).and_return(@fake_results)
    	get :similarmovies, :id => @id
    end
    
    describe 'after valid search' do

    	before :each do 
    		Movie.stub(:findsimilar).and_return(@fake_results)
    		get :similarmovies, :id => @id
    	end
    	it 'should select the Similar Movies template for rendering' do
    		response.should render_template('similarmovies')
    	end

    	it 'should make Similar Movies available to the template' do
    		assigns(:movies).should == @fake_results
    	end
    end

  end
end