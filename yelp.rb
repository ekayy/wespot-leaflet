require 'rubygems'
require 'oauth'

def yelp_search
  consumer_key = 'nv0ZLmNlKWekmHmapZ-a8A'
  consumer_secret = 'sa4WOPsvyFgh9PfgRdNk5uoVagc'
  token = 'gAGVVqJ3R3IZm4uoVaU50RDSJOPRwE1Y'
  token_secret = 'rUS8tANUHEqSB4AMDKwY0T8MGjE'

  api_host = 'api.yelp.com'

  consumer = OAuth::Consumer.new(consumer_key, consumer_secret, {:site => "http://#{api_host}"})
  access_token = OAuth::AccessToken.new(consumer, token, token_secret)

  path = "/v2/business/bar-tartine-san-francisco"
  data = access_token.get(path).body

  result = JSON.parse(data)

    return result
end

# def filter_result(result)
#   clean = []
#   result["businesses"].each { |biz| clean.insert(biz["name"]) }
#   return clean
# end