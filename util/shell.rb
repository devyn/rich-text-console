#!/usr/bin/env ruby
# A simple shell for RichTextConsole,
#   very colorful.

require 'shellwords'

# helpers
def color(c, *s)
  "\e[fc=#{c}]#{s}\e[/]"
end
def highlight(c, *s)
  "\e[bc=#{c}]#{s}\e[/]"
end
def strong(*s)
  "\e[b]#{s}\e[/]"
end
def em(*s)
  "\e[i]#{s}\e[/]"
end
def underline(*s)
  "\e[u]#{s}\e[/]"
end

# colors
def red(*s); color "ff0000", s; end
def green(*s); color "00ff00", s; end
def blue(*s); color "0000ff", s; end
def yellow(*s); color "ffff00", s; end
def magenta(*s); color "ff00ff", s; end
def cyan(*s); color "00ffff", s; end

# program

puts green("welcome to ", em("RichTextShell"), ".")

loop do
  print cyan(ENV['USER'], strong("% "))
  cmd, args = "exit".shellsplit
  break if cmd == 'exit'
  puts red("command undefined: ", strong(em(cmd)))
end

puts green("goodbye.")
