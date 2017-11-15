#!/bin/env ruby
#Checking if the page exists, parsing it using parse_md and downloading it if necessary


def check_parse_download(directory)
  page = "#{ARGV[0]}.md"
  case page_exist_where()
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
  else
    puts "HO"
  end
end
