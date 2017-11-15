#!/bin/env ruby
#Parse given markdown file

def parse_md(directory, page)
  puts "#{page_exist_where.upcase}".colorize(:background => :red)
  File.open("#{directory}/#{page}").each_line do |line|
    puts line.gsub(/#/, "---->").colorize(:color => :black, :background => :red) if /^#/ =~ line
    puts line.colorize(:yellow) if /^>/ =~ line
    puts line.gsub(/\n/, "").colorize(:green) if /^-/ =~ line
    puts line.gsub(/\{{2}/, "<").gsub(/\}{2}/, ">").gsub(/`/, "").colorize(:color => :black, :background => :blue) + "\n" if /^`/ =~ line
  end
end
