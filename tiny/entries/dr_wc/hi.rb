require 'sinatra'
require 'base64'

configure do
  @@urls = [1]
end

get '/' do
  if params[:t]
    params[:t] = Rack::Utils.escape(params[:t]) if /:\/\//.match(params[:t])
    @@urls<<params[:t]
    "#{Base64.encode64((@@urls.size - 1).to_s)}"
  else
    "I'm Tiny!"
  end
end

get '/:tiny' do
  tiny = Base64.decode64(params[:tiny])
  if tiny.to_i < @@urls.size and tiny.to_i != 0
    Rack::Utils.unescape(@@urls[tiny.to_i])
  else
    throw :halt, [404, "Not Found"]
  end
end