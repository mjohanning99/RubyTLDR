#!/usr/bin/env ruby

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

#Checking platform
unless /linux/ =~ RUBY_PLATFORM then
  puts "Only Linux is currently supported"
  exit
end

#Gems and other extensions
require 'rubygems'
require 'bundler/setup'
require 'fileutils' #Utilities for handling removing, moving (etc.) files
require 'json' #JSON parsing
require 'optparse' #Easy creation of an option parser
require 'open-uri' #For downloading
require 'socket' #For checking internet connection (pinging)
require 'zip'
require 'colorize'

#Methods
require_relative 'update_pages.rb'
require_relative 'run.rb'
require_relative 'parse_md.rb'
require_relative 'operating_system.rb'
require_relative 'extract_zip.rb'
require_relative 'formatting.rb'

#Option Parser
begin
  require_relative 'option_parser.rb'
rescue OptionParser::InvalidOption
  puts "ERROR!".colorize(:background => :red) + " The flag you entered does not exist\n" \
    "Try typing rtldr --help to get more information on how to use this program"
  exit
end

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
  run(false)
rescue Errno::ENOENT
  puts "ERROR!".colorize(:background => :red) + " RubyTldr was unable to find any pages on your machine. This is normal if you have just installed it. RubyTldr will now try to download the pages, please wait ..."
  update_pages_opt(@parent_directory)
end
