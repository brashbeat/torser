require_relative 'result_scraper'

class SearchController < ApplicationController
  include ResultScraper

  RESULT_LIST_MAPPING = { '1' => 'resultsTPB', '2' => 'resultsYTS', '3' => 'resultsXTOR' }.freeze
  
  def results
    @query = params[:query].strip.downcase
    @scope = params[:scope]
    RESULT_LIST_MAPPING[@scope]
    @results = ResultScraper.send(RESULT_LIST_MAPPING[@scope], @query)
    @template = RESULT_LIST_MAPPING[@scope]
    respond_to do |format|
      format.js
    end  
  end
  
end

