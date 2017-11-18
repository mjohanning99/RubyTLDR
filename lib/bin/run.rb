#!/bin/env ruby

#Checking if the page exists, parsing it using parse_md and downloading it if necessary
def run()
  page = "#{ARGV[0]}.md"
  case operating_system()
  when "linux"
    parse_md(@linux, page)
  when "common"
    parse_md(@common, page)
  when "windows"
    parse_md(@windows, page)
  when "osx"
    parse_md(@osx, page)
  when "sunos"
    parse_md(@sunos, page)
  when "nil"
    puts "ERROR:".colorize(:background => :red) + " You need to append an argument to the file to display the tldr (Please use tldr --help for more information)" unless $optparse
  else
    puts "ERROR:".colorize(:background => :red) + " There was no tldr page found for the command '#{ARGV[0]}'"
    puts "We are now updating the page cache, please wait"
    update_pages()
    puts "Page cache has been updated"
  end
end
