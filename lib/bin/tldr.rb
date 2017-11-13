#!/bin/env ruby

#Checking platform
unless /linux/ =~ RUBY_PLATFORM then
  puts "Only Linux is supported currently"
  exit
end

#Gems
require 'optparse'
require 'colorize'

#Predefined variables
options = {}
@optparse = false

#Pages
parent_directory = File.expand_path('..', File.dirname(__FILE__))
@lcpages = "#{parent_directory}/pages/commonlinux"

#Option Parser
OptionParser.new do |opt|
  opt.on("--help", "-h") { puts "To display a tldr page, write 'tldr' followed by the command you want to have explained. To get a list of the available commands, you can run 'tldr --list'. I would recommend using it in conjuction with a unix pipeline like so: 'tldr --list | sort | less'\n" ; @optparse = true}
  opt.on("--list", "-l") { puts Dir.entries(@lcpages) ; @optparse = true }
end.parse!

#Getting user input and displaying / formatting output
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
  puts "ERROR:".colorize(:background => :red) + " You need to append an argument to the file to display the tldr (Please use tldr --help for more information) [NoMethodError]" unless @optparse
end
