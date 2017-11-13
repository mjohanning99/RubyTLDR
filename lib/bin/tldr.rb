#!/bin/env ruby
unless /linux/ =~ RUBY_PLATFORM then
  puts "Only Linux is supported currently"
  exit
end

#Gems
require 'colorize'
# require 'redcarpet'
# require 'redcarpet/render_strip'

#Pages
@lcpages = "./lib/pages/commonlinux"

#Option Parser
begin
  Dir.entries(@lcpages).each do |page|
    if page == ARGV[0] + ".md" then
      File.open("#{@lcpages}/#{page}").each_line do |line|
        puts line.gsub(/#/, "---->").colorize(:color => :black, :background => :red) if /^#/ =~ line
        puts line.colorize(:yellow) if /^>/ =~ line
        puts line.gsub(/\n/, "").colorize(:green) if /^-/ =~ line
        puts line.gsub(/\{/, "").gsub(/\}/, "").gsub(/`/, "").colorize(:color => :black, :background => :blue)+ "\n" if /^`/ =~ line
      end
    end
  end
rescue NoMethodError
  puts "You need to append an argument to the file [e.g. ./tldr.rb tree] to display the tldr"
end
