require 'rubygems'
require 'sinatra'

$key = 0
LOOKUP = {}

get %r!/(.*)! do |key|
  if url = params[:t]
    LOOKUP[$key] = Rack::Utils.unescape(url)
    $key = $key + 1
    return ($key - 1).to_s(36)
  end

  return "I'm Tiny!" unless key && !key.empty?

  LOOKUP[key.to_i(36)] or return 404
end
