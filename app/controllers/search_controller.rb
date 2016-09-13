class SearchController < ApplicationController
require 'nokogiri'
require 'open-uri'
require 'openssl'
require 'mechanize'
require 'parallel'

  
  def index
  end

  def processor
    session[:squery] = params[:query].strip.downcase
    session[:anonymous] = params[:anonymous]
    session[:scope] = params[:scope]
    redirect_to '/results/all/1' if params[:scope] == '1'
    redirect_to '/results/tpb/1' if params[:scope] == '2'
    redirect_to '/results/yts/1' if params[:scope] == '3'
  end
  
  def resultsTPB
    
    ###### assigning user's anonymous setting from session
    
    @anon = session[:anonymous]
    
    ###### assigning user's search scope setting from session 
    
    @scope = session[:scope]
    
    ###### checks if user is searching for the first time(session) or not #######
    
    if session[:squery] && params[:pid] == '1'
      @pid = params[:pid]
      @query = session[:squery]
      
    ###### creating mechanize object
    
      @agent = Mechanize.new
    
    ###### setting user agent
    
    if session[:agent]
      @agent.user_agent_alias = session[:agent] 
    else
      @uagent = Mechanize::AGENT_ALIASES.keys - ["Mechanize","Windows IE 7","Windows IE 6"]
      @uagent = @uagent.sample
      @agent.user_agent_alias , session[:agent] = @uagent , @uagent
    end  
    
    ###### fetching search page, parsing form and assigning values to form fields
    p  @page = @agent.get('https://thepiratebay.org')
      @form = @page.form('q')
      @form.q = @query
    
    ######  submitting search form and fetching results from returned page   
      
      @page = @agent.submit(@form)
      @results = @page.xpath("//table[contains(@id, 'searchResult')]/tr[not(@class='header')]")
    
    ###### parsing next page navigation link and saving that to session  
      
      @link = @page.css('#main-content+ div a')[0]['href']
      session[:link] = "https://thepiratebay.org" + @link.strip.downcase
      
    ###### checks if user is already in a session and navigating thru links ########
    
    elsif session[:squery] && ("2".."10").include?(params[:pid])
      @pid = params[:pid]
      @query = session[:squery]
      @agent = Mechanize.new
      @agent.user_agent_alias = session[:agent]
      @page = @agent.get(session[:link])
    
    ###### parsing next page navigation link and saving that to session  
      
      @link = @page.css('#main-content+ div a')[@pid.to_i]['href']
      session[:link] = "https://thepiratebay.org" + @link.strip.downcase
    
    ######  parsing results from fetched page
      @results = @page.xpath("//table[contains(@id, 'searchResult')]/tr[not(@class='header')]")
    
    ###### if no session detected 
    else  
    redirect_to '/' and return
    end
  end
  
  def resultsYTS
    ###### assigning user's anonymous setting from session
    
    @anon = session[:anonymous]
    
    ###### assigning user's search scope setting from session 
    
    @scope = session[:scope]
    
    ###### checks if user is searching for the first time(session) or not #######
    
    if session[:squery] # && params[:pid] == '1'
      # @pid = params[:pid]
      @query = session[:squery]
      @page = Nokogiri::HTML(open("https://yts.ag/api/v2/list_movies.json?query_term=#{@query}&limit=50")) 
      @page_hash = JSON.parse @page
      
    else  
    redirect_to '/' and return
    end
  end
  
  def all
    ###### assigning user's anonymous setting from session
    
    @anon = session[:anonymous]
    
    ###### assigning user's search scope setting from session 
    
    @scope = session[:scope]
  
    ##### checks if user is searching for the first time(session)  
   if session[:squery] && params[:pid] == '1'
      @pid = params[:pid]
      @query = session[:squery]
   ###################################### 
   arr = []
   
   arr << Thread.new { 
      @page = Nokogiri::HTML(open("https://yts.ag/api/v2/list_movies.json?query_term=#{@query}&limit=50")) 
      @page_hash = JSON.parse @page 
     }
   
   arr << Thread.new { 
      
    ###### creating mechanize object
    
      @agent = Mechanize.new
    
    ###### setting user agent
    
    if session[:agent]
      @agent.user_agent_alias = session[:agent] 
    else
      @uagent = Mechanize::AGENT_ALIASES.keys - ["Mechanize","Windows IE 7","Windows IE 6"]
      @uagent = @uagent.sample
      @agent.user_agent_alias , session[:agent] = @uagent , @uagent
    end  
    
    ###### searching and fetching result page
      @page = @agent.get("https://thepiratebay.org/s/?q=#{@query}&category=0&page=0&orderby=99")
    
    ######  parsing results from fetched page
      @results = @page.xpath("//table[contains(@id, 'searchResult')]/tr[not(@class='header')]")
   }
   Parallel.map(arr, in_threads: 2) do |t|
   t.join
   end  
    else
  redirect_to '/' and return
   end    
  end
  
  
  
end
