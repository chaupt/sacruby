#! /usr/bin/env ruby
# == Synopsis
# Crawls Google for a pile of URLs for test data. WARNING, this will get you locked out if used improperly
#
# == Usage
# spider.rb url
#
# == Author
# Chris Haupt
#

$:.unshift File.join(File.dirname(__FILE__), ".")

require 'rubygems'
require 'nokogiri'
require 'fileutils'
require 'net/http'
require 'uri'

def usage
  puts <<-END
Usage: spider.rb
END
end
 
class RubySpider
  attr_accessor :crawl_url, :start_param, :start_increment
    
  def initialize
    self.crawl_url = "http://www.google.com/search?hl=en&q=ruby+programming&sa=N&start="
    self.start_increment = 10
  end

  def collect_results_from_slugger!
    0.upto(5) do |i|
      a_url = "#{crawl_url}#{i * start_increment}"
      uri = URI.parse(a_url)
      http = Net::HTTP.new(uri.host, uri.port)
      response = http.start {|h| h.request(Net::HTTP::Get.new(uri.request_uri))}

      if response.content_type =~ /text\/html/
        scan_and_collect!(response, a_url)
      end
      sleep(5.0)
    end
  end

  def scan_and_collect!(response, a_url)
    doc = Nokogiri::HTML.parse(response.body)
    nodes = doc.search("#res ol li a")
    nodes.each do |node|
      url = node.attributes['href'].content
      url = "http://www.google.com" + url unless url =~ /^http/i
      puts url
    end
  end

  def run
    collect_results_from_slugger!
    true
  end
    
end

RubySpider.new().run