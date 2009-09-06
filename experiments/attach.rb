#(Shoes)
# Technically, it doesn't have to be this complicated
#   but this way reduces flicker [from being multi-threaded].

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
  @process = RichTextConsole::ExternalProcess.new("ruby ../util/shell.rb")
  @queue   = []
  @rtc     = {:gst => {:stroke => "#ffffff", :family => "Inconsolata", :size => 14, :margin => 0}}
  @bsable  = 0
  @inline  = ""

  @process.attach { |s| next unless s.is_a?(String); @queue << @parser.parse(s); @bsable = 0 }

  animate do
    next unless x = @queue.shift
    x.shoes(self)
  end

  keypress do |key|
    case key
    when :backspace, :delete
      @inline.sub!(/.$/,'')
      @parser.parse("\e[.d 1]").shoes(self) if @bsable >= 1
      @bsable -= 1
    when "\n", :enter, :return
      @process.write "#@inline\n"
      @rtc[:track] << para("\n", @rtc[:style])
      @inline = ""
      @bsable = 0
    when String
      @inline << key
      @rtc[:track] << para(key, @rtc[:style])
      @bsable += 1
    end
  end
end
