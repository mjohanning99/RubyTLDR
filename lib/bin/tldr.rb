#!/bin/env ruby

=begin
Copyright 2017-2020 Marvin Johanning
This file is part of RubyTldr (rtldr).

Reeder is free software: you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation, either version 3 of the License, or
(at your option) any later version.

Reeder is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU General Public License for more details.

You should have received a copy of the GNU General Public License
along with Reeder.  If not, see <http://www.gnu.org/licenses/>.
=end

#Checking platform
unless /linux/ =~ RUBY_PLATFORM then
  puts "Only Linux is currently supported"
  exit
end

#Gems and other extensions
require 'fileutils' #Utilities for handling removing, moving (etc.) files
require 'json' #JSON parsing
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
