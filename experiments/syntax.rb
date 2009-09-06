#(Shoes)

Shoes.setup do
  gem 'treetop'
end

$:.unshift File.expand_path(File.join(File.dirname(__FILE__), '..', 'lib'))

require 'rubygems'
require 'rtc/rtdl'

Shoes.app do
  background black

  @string = "\e[.cl 002222]\e[b,fc=22ccff]Shoes\e[/].app \e[fc=dd9900]do\e[/]
  \e[fc=999999,i]# this is pure Shoes awesomeness.\e[/]
  \e[fc=dd3300]button\e[/](\e[fc=66dd66]\e[fc=dd9900]\"\e[/]Click Me!\e[fc=dd9900]\"\e[//]) \e[bc=333333]{\e[/]
    \e[fc=dd3300]alert\e[/] \e[fc=66dd66]\e[fc=dd9900]\"\e[/]You clicked me!\e[fc=dd9900]\"\e[//]
  \e[bc=333333]}\e[/]\n\e[fc=dd9900]end\e[/]"

  @parser = RichTextConsole::RTDLParser.new

  @rtc = {
    :gst => {
      :family => "Inconsolata", :size => 14, :stroke => "#ffffff", :margin => 0
    }
  }

  pa = @parser.parse(@string)
  pa.shoes(self)
end
