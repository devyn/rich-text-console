#!/usr/bin/env ruby
# A simple shell for RichTextConsole
#   using RuSh... and very pretty.

require 'rush'

module Kernel
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
  def size(n, *s)
    "\e[fs=#{n}]#{s}\e[/]"
  end

  # colors
  def red(*s); color "ff0000", s; end
  def green(*s); color "00ff00", s; end
  def blue(*s); color "0000ff", s; end
  def yellow(*s); color "ffff00", s; end
  def magenta(*s); color "ff00ff", s; end
  def cyan(*s); color "00ffff", s; end
end

# rush modifications
class Rush::SearchResults
  # ( ansi-style rtc )
  # inversed from RuSh, because typically RTC has background black.
  def lowlight
    "\e[bc=000033,fc=cccccc]"
  end
  def hilight
    "\e[bc=ffffff,fc=000033]"
  end
  def normal
    "\e[//]"
  end
end

class Rush::Shell
		# Run a single command.
		def execute(cmd)
			res = eval(cmd, @pure_binding)
			$last_res = res
			eval("_ = $last_res", @pure_binding)
			print_result res
		rescue Rush::Exception => e
			puts "\e[fc=ff6666]Exception \e[b]#{e.class}\e[/] -> \e[i]#{e.message}\e[//]"
		rescue ::Exception => e
			puts "\e[fc=ff3333]Exception \e[b]#{e.class}\e[/] -> \e[i]#{e.message}\e[//]"
			e.backtrace.each do |t|
        fm = t.split(":")
        fm[0] = "\e[fc=ffff66]#{::File.expand_path(fm[0])}\e[/]"
        fm[1] = "\e[fc=33bb33]#{fm[1]}\e[/]"
        fm[2] = "\e[fc=ff99ff]#{fm[2]}\e[/]"
				puts "   #{fm.join(":")}"
			end
		end

		# Nice printing of different return types, particularly Rush::SearchResults.
		def print_result(res)
			return if self.suppress_output
			if res.kind_of? String
				puts res
			elsif res.kind_of? Rush::SearchResults
				widest = res.entries.map { |k| k.full_path.length }.max
				res.entries_with_lines.each do |entry, lines|
					print "\e[fc=66bb66,b]#{entry.full_path}\e[/]"
					print ' ' * (widest - entry.full_path.length + 2)
					print "\e[b]=>\e[/] "
					print res.colorize(lines.first.strip.head(30))
					print "..." if lines.first.strip.length > 30
					if lines.size > 1
						print " \e[i,fc=99cccc](plus #{lines.size - 1} more matches)\e[/]"
					end
					print "\n"
				end
				puts "\e[i,fc=66aaff]\e[b,fc=00aaff]#{res.entries.size}\e[/] matching files with \e[b,fc=00aaff]#{res.lines.size}\e[/] matching lines\e[/]"
			elsif res.respond_to? :each
				counts = {}
				res.each do |item|
					puts item
					counts[item.class] ||= 0
					counts[item.class] += 1
				end
				if counts == {}
					puts "\e[b]=>\e[/] \e[i,fc=66dddd](empty set)\e[/]"
				else
					count_s = counts.map do |klass, count|
						"#{count} x \e[u]#{klass}\e[/]"
					end.join(', ')
					puts "\e[b]=>\e[/] \e[i,fc=66dddd]#{count_s}\e[/]"
				end
			else
				puts "\e[b]=>\e[/] \e[fc=22dd22]#{res.inspect}\e[/]"
			end
		end

end

# program

$stdout.sync = true

$stdout.write size(16, green("welcome to ", em("RichTextShell"), "."), "\n")
$stdout.write size(16, green("  type any ", strong("ruby"), " or ", strong("rush"), " code to run it."), "\n")

sh = Rush::Shell.new

loop do
  $stdout.write cyan(ENV['USER'], color('66cccc', "% "))
  break unless g = $stdin.gets
  sh.execute(g)
end

$stdout.write green("goodbye.") + "\n"
