require 'rest-client'
require 'nokogiri'

module ResultScraper

  def self.resultsTPB(query)
      page = Nokogiri::HTML(RestClient.get("https://thepiratebay.org/s/?q=#{query}&category=0&page=0&orderby=99").body)
      page.xpath("//table[contains(@id, 'searchResult')]/tr[not(@class='header')]")
	end

	def self.resultsYTS(query)
		  page = Nokogiri::HTML(RestClient.get("https://yts.ag/api/v2/list_movies.json?query_term=#{query}&limit=50").body) 
  	  JSON.parse page
	end 

	def self.resultsXTOR(query)
    	page = Nokogiri::XML(open("https://extratorrent.cc/rss.xml?type=search&search=#{query}")) 
      page.xpath('//item')
	end

end