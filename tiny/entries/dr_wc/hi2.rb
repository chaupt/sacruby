require 'sinatra'
require 'base64'

configure do
  @@urls = [1]
end

get '/' do
  if params[:t]
    @@urls<<params[:t]
    "#{@@urls.size - 1}"
  else
    "I'm Tiny!"
  end
end

get '/:tiny' do
  tiny = params[:tiny].to_i
  if tiny < @@urls.size and tiny != 0
    Rack::Utils.unescape(@@urls[tiny])
  else
    throw :halt, [404, "Not Found"]
  end
end