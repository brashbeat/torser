# Torser

[![Torser](https://s3.amazonaws.com/aws-website-resume-amulaya-kh8y5/torser_logo.png)](https://torser.in)

Torser is a metasearch engine built on Rails 5.1 and uses Ruby's HTML parsing libraries to scrape search results from torrent portals and formats them as magnet links. It currently scrapes -

  - [thepiratebay](https://thepiratebay.org)
  - [yifytorrents](https://yts.ag)
  - [extratorrent](https://extratorrent.cc) (update May '17: permanently shutdown)

## Setup (development env)
 ```sh
  git clone https://github.com/logwolvy/torser.git && cd torser
  bundle install --without production
  bundle exec rake assets:precompile db:create db:migrate RAILS_ENV=production
  bundle exec rake gen_config #generates dummy mail server credentials
  bundle exec rails s      
 ```
### Contribute

You can help add more torrent portals to make this more resourceful.  

* Add the new method to the module as shown below
```ruby
# /app/controllers/result_scraper.rb
...
# fetches json from YTS api
def self.resultsYTS(query)
    page = Nokogiri::HTML(RestClient.get("https://yts.ag/api/v2/list_movies.json?query_term=#{query}&limit=50").body) 
  	JSON.parse page
end
...
```
* Add the method name to mapping
```ruby
# /app/controllers/search_controller.rb
...
  RESULT_LIST_MAPPING = { '1' => 'resultsTPB', '2' => 'resultsYTS', '3' => 'resultsXTOR' }.freeze
...  
```
* And create the corresponding view (partial)

### DEMO

Available at https://torser.in/

Deployment Specs  
* AWS EC2 instance (Ubuntu 16.04)
* Passenger-ruby
* Nginx
* Ruby 2.3.4
 

License
------

MIT
