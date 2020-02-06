#!/bin/env ruby

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

#The option parser that parses the "--help", "--list" and "--update" options, most of which don't work anymore after the restructuring.
#TODO Rewrite option parser using ARGV[0] instead

#Require update_pages.rb so that --update can be used
require_relative 'update_pages.rb'

parent_directory = File.expand_path('..', File.dirname(__FILE__))
OptionParser.new do |opt|
  opt.on("--help", "-h") { puts "HELP:".colorize(:color => :black, :background => :green) + " To display a tldr page, write 'tldr' followed by the command you want to have explained.\nWords surrounded by '<>' are files / commands the user needs to add themselves.\nTo get a list of the available commands, you can run 'tldr --list'. I would recommend using it in conjuction with a unix pipeline like so: 'tldr --list | sort | less'\nTo update the list of pages, you can run tldr --update\nTo get even more information about this program, please refer to the README file located in #{File.expand_path('../..', File.dirname(__FILE__))}" ; $optparse = true ; exit }
  opt.on("--list", "-l") { puts Dir.entries("#{parent_directory}/pages/linux") ; puts Dir.entries("#{parent_directory}/pages/common") ; puts Dir.entries("#{parent_directory}/pages/windows") ; puts Dir.entries("#{parent_directory}/pages/osx") ; puts Dir.entries("#{parent_directory}/pages/sunos") ; $optparse = true ; exit }
  opt.on("--update", "-u") { update_pages_opt(parent_directory) ; $optparse = true ; exit}
end.parse!
