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

$stdout.sync = true

$stdout.write green("welcome to ", em("RichTextShell"), ".") + "\n"

loop do
  $stdout.write cyan(ENV['USER'], strong("% "))
  break unless g = $stdin.gets
  cmd, args = g.chomp.shellsplit
  break if cmd == 'exit'
  $stdout.write red("command undefined: ", strong(em(cmd))) + "\n"
end

$stdout.write green("goodbye.") + "\n"
