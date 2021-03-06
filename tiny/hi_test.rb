# Prereq: sudo gem install rack-test

require 'hi'
require 'test/unit'
require 'rack/test'
require 'rack/utils'

set :environment, :test

class HiTest < Test::Unit::TestCase
  include Rack::Test::Methods

  TEST_URLS = ["http://www.google.com", "http://www.sinatrarb.com/intro.html", "http://www.amazon.com/Blu-ray-movies-discs-store-deals/b/ref=sa_menu_blu1?ie=UTF8&node=193640011&pf_rd_p=328655101&pf_rd_s=left-nav-1&pf_rd_t=101&pf_rd_i=507846&pf_rd_m=ATVPDKIKX0DER&pf_rd_r=0ZK65CR5RWCRCJJKZM6R", "http://tech.slashdot.org/story/09/11/17/2115218/The-Jet-Fighter-Laser-Cannon", "http://spaceflightnow.com/shuttle/sts129/091117fd2/index2.html" ]
  
  def app
    Sinatra::Application
  end

  def test_it_says_hi
    get '/'
    assert last_response.ok?
    assert_equal "I'm Tiny!", last_response.body
  end
  
  def test_it_makes_us_tiny
    get '/', :t => Rack::Utils.escape('http://www.webvanta.com/')
    assert last_response.ok?
  end

  def test_it_makes_us_big_again
    get '/', :t => Rack::Utils.escape('http://www.webvanta.com/')
    assert last_response.ok?
    get "/#{last_response.body}"
    assert last_response.ok?
    assert_equal "http://www.webvanta.com/", last_response.body
  end
  
  def test_it_does_not_have_key
    get '/T'
    assert last_response.not_found?
  end
  
  def test_it_converts_and_reconstitutes_urls
    buffer = []
    encode_errors = 0
    decode_errors = 0
    success = 0
    original_len = 0.0
    total_len = 0.0
    TEST_URLS.each do |f| 
      get '/', :t => Rack::Utils.escape(f)
      if last_response.ok?
        buffer << [f, last_response.body]
        original_len += f.length
        total_len += last_response.body.length
      else
        encode_errors += 1 
      end
    end
    # get them back
    buffer.each do |pair|
      get "/#{pair[1]}"
      if last_response.ok?
        if last_response.body != pair[0]
          decode_errors += 1
        else
          success += 1
        end
      else
        decode_errors += 1
      end
    end
    original_len = 1.0 if original_len.to_i < 1
    puts "Success: #{success}, Total Len: #{total_len} Original Len: #{original_len}, Ratio: #{(total_len/original_len)*100.0}, Encode Errors: #{encode_errors}, Decode Errors: #{decode_errors}"
  end
end