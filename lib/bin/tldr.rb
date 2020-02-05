#!/bin/env ruby

#Checking platform
unless /linux/ =~ RUBY_PLATFORM then
  puts "Only Linux is currently supported"
  exit
end

#Gems and other extensions
require 'fileutils' #Utilities for handling removing, moving (etc.) files
require 'optparse' #Easy creation of an option parser
require 'open-uri' #For downloading
require 'socket' #For checking internet connection (pinging)
begin
  require 'colorize' #To colour the output
rescue LoadError
  `sudo gem install colorize`
  puts "You did not have the colorize gem installed when starting this program. We tried installing it, please run the program again and see if it works correctly. If it does not work, please refer to the README and file an issue on https://github.com/jeytas/rubytldr if nothing else works"
  exit
end
begin
  require 'zip' #To extract the zip file downloaded using open-uri
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
@linux = "#{@parent_directory}/pages/linux"
@common = "#{@parent_directory}/pages/common"
@windows = "#{@parent_directory}/pages/windows"
@sunos = "#{@parent_directory}/pages/sunos"
@osx = "#{@parent_directory}/pages/osx"

#Running the actual program
begin
  run()
rescue Errno::ENOENT
  puts "ERROR!".colorize(:background => :red) + " RubyTldr was unable to find any pages on your machine. This is normal if you have just installed it. RubyTldr will now try to download the pages, please wait ..."
  update_pages_opt(@parent_directory)
end
