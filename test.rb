#(Shoes)

Shoes.setup do
  gem 'treetop'
end

$:.unshift File.join(File.dirname(__FILE__), 'lib')

require 'rubygems'
require 'rtc/rtdl'

Shoes.app do
  background black
  @parser = RichTextConsole::RTDLParser.new
  @parser \
    .parse("\e[b,fc=22ccff]Shoes\e[/].app \e[fc=dd9900]do\e[/]\n  \e[fc=dd3300]button\e[/](\e[fc=66dd66]\"Click Me!\"\e[/]) \e[bc=333333]{\e[/]\n    \e[fc=dd3300]alert\e[/] \e[fc=66dd66]\"You clicked me!\"\e[/]\n  \e[bc=333333]}\e[/]\n\e[fc=dd9900]end\e[/]") \
    .shoes(self, :font => "Inconsolata 14", :stroke => "#ffffff", :margin => 0)
end
