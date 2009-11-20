require 'uri'
require 'rubygems'
require 'sinatra'

# KEYS = (0..9).to_a + ('a'..'z').to_a + ('A'..'Z').to_a + %w{ $ - _ . + ! * ' ( ) , }
KEYS = (0..9).to_a + ('a'..'z').to_a + ('A'..'Z').to_a
BAD_KEYS = ['T']
KEYGEN = lambda do |i, base|
  
  if foo > 1
    self.call(foo)
  else
  end
  output
end

def generate_next_key
  index = Dir.entries("datastore").size - 1
  
  get_key_for(index)
end

def get_key_for(number)
   number = Integer(number);
   hex_digit = KEYS
   ret_hex = '';
   while(number != 0)
      ret_hex = String(hex_digit[number % 16 ] ) + ret_hex;
      number = number / 16;
   end
   return ret_hex; ## Returning HEX
end

def encode(url)
  key = generate_next_key
  
  File.open( "datastore/#{key}", 'w' ) do |f|
    f.write(URI.unescape(url))
  end
  
  key.to_s
end

def decode(key)
  insides = nil
  File.open( "datastore/#{key}", 'r' ) do |f|
    insides = f.read
  end if File.exists?("datastore/#{key}")
  insides
end

get '/' do
  if params[:t]
    encode(params[:t])
  else
    "I'm Tiny!"
  end
end

get '/:key' do
  url = decode(params[:key])
  if url.nil?
    halt 404
  else
    url
  end
end
