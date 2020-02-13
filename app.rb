require 'bundler'
Bundler.require 

configure do
	use Rack::Cors do
		allow do
			origins '*'
			resource '*', headers: :any, methods: [:get, :post, :options]
		end
	end
end

get '/' do
	feeds  =FeedSearcher.search(params[:url]).map{|x|
    body = RestClient.get(x)
    parsed = Feedjira.parse(body)
    entries = parsed.entries.map{|x| x.to_h }
    description = parsed.description
    {url: x, title: parsed.title, entries: entries, description: description}
  }
  content_type :json
  feeds.to_json
rescue => e
  'error'
end
