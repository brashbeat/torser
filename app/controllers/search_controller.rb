class SearchController < ApplicationController
require 'nokogiri'
require 'open-uri'
require 'openssl'
  
  def index
  end

  def processor
    @query = params[:query].strip.downcase.split.join('%20')
    @address = "https://thepiratebay.org/search/#{@query}/0/99/0" 
    @base = Nokogiri::HTML(open(@address, :ssl_verify_mode => OpenSSL::SSL::VERIFY_NONE))
    @results = @base.css('.vertTh+ td')
    
  end

  def results
    render html: "You searched for #{session[:squery]}"
  end
end
