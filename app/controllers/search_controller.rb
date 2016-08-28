class SearchController < ApplicationController
require 'nokogiri'
require 'open-uri'
require 'openssl'
require 'mechanize'

  
  def index
  end

  def processor
    session[:squery] = params[:query].strip.downcase
    redirect_to '/results/1'
  end
  
  def next
    
  end

  def results
    
    if session[:squery] && params[:pid] == '1'
      @pid = params[:pid]
      # @query = params[:query].strip.downcase.split.join('%20')
      @query = session[:squery]
    # creating mechanize object
      @agent = Mechanize.new
    if session[:agent]
      @agent.user_agent_alias = session[:agent] 
    else
      @uagent = Mechanize::AGENT_ALIASES.keys - ["Mechanize","Windows IE 7","Windows IE 6"]
      @uagent = @uagent.sample
      @agent.user_agent_alias , session[:agent] = @uagent , @uagent
    end  
      @page = @agent.get('https://thepiratebay.org')
      @form = @page.form('q')
      @form.q = @query
      @page = @agent.submit(@form)
    # @address = "https://thepiratebay.org/search/#{@query}/0/99/0" 
    # @base = Nokogiri::HTML(open(@address, :ssl_verify_mode => OpenSSL::SSL::VERIFY_NONE))
      @results = @page.css('.vertTh+ td')
      @info = @page.css('.vertTh~ td+ td')
      @link = @page.css('#main-content+ div a')[0]['href']
      session[:link] = "https://thepiratebay.org" + @link.strip.downcase
      
    elsif session[:squery] && ("2".."10").include?(params[:pid])
      @pid = params[:pid]
      @query = session[:squery]
      @agent = Mechanize.new
      @agent.user_agent_alias = session[:agent]
      @page = @agent.get(session[:link])
      @info = @page.css('.vertTh~ td+ td')
      @link = @page.css('#main-content+ div a')[@pid.to_i]['href']
      session[:link] = "https://thepiratebay.org" + @link.strip.downcase
      @results = @page.css('.vertTh+ td')
    else  
    redirect_to '/'
    end
  end
  
  
end
