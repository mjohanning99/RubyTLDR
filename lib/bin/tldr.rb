#!/bin/env ruby

#Checking platform
unless /linux/ =~ RUBY_PLATFORM then
  puts "Only Linux is currently supported"
  exit
end

#Gems and other extensions
require 'fileutils'
require 'optparse'
require 'open-uri'
begin
  require 'colorize'
rescue LoadError
  `sudo gem install colorize`
  puts "You did not have the colorize gem installed when starting this program. We tried installing it, please run the program again and see if it works correctly. If it does not work, please refer to the README and file an issue on https://github.com/jeytas/rubytldr if nothing else works"
  exit
end
begin
  require 'zip'
rescue LoadError
  `sudo gem install rubyzip`
  puts "You did not have the rubyzip gem installed when starting this program. We tried installing it, please run the program again and see if it works correctly. If it does not work, please refer to the README and file an issue on https://github.com/jeytas/rubytldr if nothing else works"
  exit
end

#Methods
require_relative 'update_pages.rb'
require_relative 'run.rb'
require_relative 'parse_md.rb'
require_relative 'operating_system.rb'
require_relative 'extract_zip.rb'

#Option Parser
require_relative 'option_parser.rb'

#Predefined variables
@parent_directory = File.expand_path('..', File.dirname(__FILE__))

#Pages
#TODO : Check if /pages directory exist and only if it does create these, otherwise exit program saying that the /pages directory has been removed
@linux = "#{@parent_directory}/pages/linux"
@common = "#{@parent_directory}/pages/common"
@windows = "#{@parent_directory}/pages/windows"
@sunos = "#{@parent_directory}/pages/sunos"
@osx = "#{@parent_directory}/pages/osx"

#Running the actual program
run()
