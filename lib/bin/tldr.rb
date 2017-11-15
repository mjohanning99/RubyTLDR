#!/bin/env ruby

#Checking platform
unless /linux/ =~ RUBY_PLATFORM then
  puts "Only Linux is supported currently"
  exit
end

#Gems
require 'optparse'
begin
  require 'colorize'
rescue LoadError
  `gem install colorize`
  puts "You did not have the colorize gem installed when starting this program. We tried installing it, please run the program again and see if it works correctly. If it does not, please create an issue on this project't Github repository"
  exit
end

#Methods
require_relative 'download_new_pages.rb'
require_relative 'check_parse_download.rb'
require_relative 'parse_md.rb'
require_relative 'page_exist_where.rb'

#Predefined variables
options = {}
@optparse = false
@parent_directory = File.expand_path('..', File.dirname(__FILE__))

#Pages
@linux = "#{@parent_directory}/pages/linux"
@common = "#{@parent_directory}/pages/common"
@windows = "#{@parent_directory}/pages/windows"
@sunos = "#{@parent_directory}/pages/sunos"
@osx = "#{@parent_directory}/pages/osx"

#Option Parser
OptionParser.new do |opt|
  opt.on("--help", "-h") { puts "HELP:".colorize(:background => :green) + " To display a tldr page, write 'tldr' followed by the command you want to have explained.\nWords surrounded by '<>' are files / commands the user needs to add themselves.\nTo get a list of the available commands, you can run 'tldr --list'. I would recommend using it in conjuction with a unix pipeline like so: 'tldr --list | sort | less'\nTo update the list of pages, you can run tldr --update\nTo get even more information about this program, please refer to the README file located in #{File.expand_path('../..', File.dirname(__FILE__))}" ; @optparse = true}
  opt.on("--list", "-l") { puts Dir.entries(@linux) ; @optparse = true }
  opt.on("--update", "-u") { `bash #{@parent_directory}/bin/update_pages.sh` ; exit }
end.parse!

#Getting user input and displaying / formatting output
check_parse_download(@linux)
puts page_exist_where
