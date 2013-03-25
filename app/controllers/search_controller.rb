include SearchHelper

class SearchController < ApplicationController

	# GET /search
  	# GET /search.json
  	def index
  		if params[:search_term]
   			@search_results = search_games(params[:search_term])
   		end

    	respond_to do |format|
      		format.html # index.html.erb
      		format.json { render json: @search_results }
    	end
  	end
end
