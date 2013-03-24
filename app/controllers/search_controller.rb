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

  	def create

		@search_term = params["search"]

		puts @search_term

		respond_to do |format|
      		format.html { redirect_to search_index_path :search_term => @search_term } # index.html.erb
      		format.json { render json: @search_results }
    	end

  	end
end
