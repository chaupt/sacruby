# Prereq: sudo gem install rack-test

require 'hi'
require 'test/unit'
require 'rack/test'
require 'benchmark'
require 'rack/utils'

set :environment, :test

class HiTest < Test::Unit::TestCase
  include Rack::Test::Methods
    
  def app
    Sinatra::Application
  end

  def test_for_competition
    urls = []
    File.open("test.txt") do |f|
      urls = f.readlines
    end
    puts "URLs = #{urls.length}"
    encoded = []
    teerr = tderr = succ = olen = tlen = 0
    results = []
    urls.each {|f| encoded << Rack::Utils.escape(f)}
    Benchmark.benchmark(nil, nil, nil, ">total:", ">avg:") do |x|
      10.times do |tim|
        buffer = []
        encode_errors = 0
        decode_errors = 0
        successful = 0
        original_len = 0.0
        total_len = 0.0
        results[tim] = x.report("Trial #{tim} ") do
          encoded.each_with_index do |f, i| 
            get '/', :t => f
            if last_response.ok?
              buffer << [i, last_response.body]
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
              if last_response.body != urls[pair[0]]
                decode_errors += 1
              else
                successful += 1
              end
            else
              decode_errors += 1
            end
          end
          teerr += encode_errors
          tderr += decode_errors
          succ += successful
          olen += original_len
          tlen += total_len
          successful = 0
        end
      end
      tt = results[0]
      results[1..9].each {|r| tt += r }
      [tt, tt/10.0]
    end
    olen = 1.0 if olen < 1.0
    puts "Success: #{succ}, Total Len Avg: #{tlen/10.0} Original Len Avg: #{olen/10.0}, Ratio: #{(tlen/olen)*100.0}, Encode Errors: #{teerr}, Decode Errors: #{tderr}"
    
  end
end