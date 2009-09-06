#(Shoes)
# Technically, it doesn't have to be this complicated
#   but this way reduces flicker.

Shoes.setup do
  gem 'treetop'
end

$:.unshift File.expand_path(File.join(File.dirname(__FILE__), '..', 'lib'))

require 'rubygems'
require 'rtc/rtdl'
require 'rtc/io'

Shoes.app do
  background black
  
  @parser  = RichTextConsole::RTDLParser.new
  @process = RichTextConsole::ExternalProcess.new("curl http://github.com/feeds/devyn/commits/rich-text-console/master")
  @queue   = []
  @rtc     = {:gst => {:stroke => "#ffffff", :family => "Inconsolata", :size => 14, :margin => 0}}

  @process.attach { |s| next unless s.is_a?(String); @queue << @parser.parse(s) }

  animate do
    next unless x = @queue.shift
    x.shoes(self)
  end
end
