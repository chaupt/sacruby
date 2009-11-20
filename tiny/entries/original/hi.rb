require 'rubygems'
require 'sinatra'
require 'rack/utils'

@@key = 0
@@cache = {}
get '/' do
  if params[:t]
    @@key += 1 
    @@cache[@@key.to_s] = Rack::Utils.unescape(params[:t])
    @@key.to_s
  else
    "I'm Tiny!"
  end
end

get '/*' do
  @cache ||= {}
  if params[:splat]
    if @@cache[params[:splat].first]
      halt(@@cache[params[:splat].first] )
    else
      halt(404)
    end
  else
    "I'm Tiny!"
  end
end
