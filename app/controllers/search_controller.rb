class SearchController < ApplicationController
require 'nokogiri'
require 'open-uri'
require 'openssl'
require 'mechanize'
  
  def index
  end

  def processor
  if params[:query]
    # @query = params[:query].strip.downcase.split.join('%20')
    @query = params[:query].strip.downcase
    @agent = Mechanize.new
    @page = @agent.get('https://thepiratebay.org')
    @form = @page.form('q')
    @form.q = @query
    @page = @agent.submit(@form)
  # @address = "https://thepiratebay.org/search/#{@query}/0/99/0" 
  # @base = Nokogiri::HTML(open(@address, :ssl_verify_mode => OpenSSL::SSL::VERIFY_NONE))
    @results = @page.css('.vertTh+ td')
  else
    redirect_to '/'
  end  
  end
  
  def next
    
  end

  def results
    render html: "You searched for #{session[:squery]}"
  end
end
