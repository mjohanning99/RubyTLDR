#!/bin/env ruby

=begin
Copyright 2017-2020 Marvin Johanning
This file is part of RubyTldr (rtldr).

RubyTldr is free software: you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation, either version 3 of the License, or
(at your option) any later version.

RubyTldr is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU General Public License for more details.

You should have received a copy of the GNU General Public License
along with RubyTldr.  If not, see <http://www.gnu.org/licenses/>.
=end

#Parse given markdown file
def parse_md(directory, page, manual)
  unless manual == true
    puts "#{operating_system.upcase}".colorize(:background => :red) unless operating_system == "common"
    File.open("#{directory}/#{page}").each_line do |line|
      print line.gsub(/#/, "").colorize(:background => :red, :color => :black) if /^#/ =~ line
      print line.colorize(:yellow) if /^>/ =~ line
      puts line.gsub(/\n/, "").colorize(:green) if /^-/ =~ line
      print "  " + line.gsub(/\{{2}/, "<").gsub(/\}{2}/, ">").gsub(/`/, "").colorize(:color => :black, :background => :blue) + "\n" if /^`/ =~ line
    end
  else
    puts "#{ARGV[1].upcase}".colorize(:background => :red) unless ARGV[1] == "common"
    File.open("#{directory}/#{page}").each_line do |line|
      print line.gsub(/#/, "").colorize(:background => :red, :color => :black) if /^#/ =~ line
      print line.colorize(:yellow) if /^>/ =~ line
      puts line.gsub(/\n/, "").colorize(:green) if /^-/ =~ line
      print "  " + line.gsub(/\{{2}/, "<").gsub(/\}{2}/, ">").gsub(/`/, "").colorize(:color => :black, :background => :blue) + "\n" if /^`/ =~ line
    end
  end
end

