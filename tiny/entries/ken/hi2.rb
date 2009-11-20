require 'rubygems'
require 'sinatra'

$index = 1
$known = {}
$rev_known = {}

get '/' do
  if big = params[:t]
    generate(Rack::Utils.unescape(big))
  else
    "I'm Tiny!"
  end
end

get '/:tiny' do |tiny|
  restore(tiny)
end

def generate(url)

  already = $rev_known[url]
  if already
    already
  else
    key = encode($index)
    $known[key] = url
    $rev_known[url] = key
    $index += 1
    key
  end

end

def restore(index)]
    $known[index] || raise Sinatra::NotFound
  end
end

CHARS ={60=>"Y", 49=>"N", 38=>"C", 27=>"r", 16=>"g", 5=>"5", 55=>"T", 44=>"I", 33=>"x", 22=>"m", 11=>"b", 0=>"0", 61=>"Z", 50=>"O", 39=>"D", 28=>"s", 17=>"h", 6=>"6", 56=>"U", 45=>"J", 34=>"y", 23=>"n", 12=>"c", 1=>"1", 62=>"-", 51=>"P", 40=>"E", 29=>"t", 18=>"i", 7=>"7", 57=>"V", 46=>"K", 35=>"z", 24=>"o", 13=>"d", 2=>"2", 63=>"_", 52=>"Q", 41=>"F", 30=>"u", 19=>"j", 8=>"8", 58=>"W", 47=>"L", 36=>"A", 25=>"p", 14=>"e", 3=>"3", 64=>".", 53=>"R", 42=>"G", 31=>"v", 20=>"k", 9=>"9", 59=>"X", 48=>"M", 37=>"B", 26=>"q", 15=>"f", 4=>"4", 65=>"~", 54=>"S", 43=>"H", 32=>"w", 21=>"l", 10=>"a"}

def encode(num)
  str = ''
  while num != 0
    str << CHARS[num % 66]
    num /= 66
  end
  str
end


