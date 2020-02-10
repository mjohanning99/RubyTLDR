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

#Require update_pages.rb so that --update can be used
require_relative 'update_pages.rb'

parent_directory = File.expand_path('..', File.dirname(__FILE__))
OptionParser.new do |opt|

  opt.banner = "Usage: rtldr [options]"

  opt.on("--help", "-h", "Prints this help") do
    puts opt
    exit
  end

  opt.on("--list", "-l", "Lists all the available commands") { puts Dir.entries("#{parent_directory}/pages/linux") ; puts Dir.entries("#{parent_directory}/pages/common") ; puts Dir.entries("#{parent_directory}/pages/windows") ; puts Dir.entries("#{parent_directory}/pages/osx") ; puts Dir.entries("#{parent_directory}/pages/sunos") ; exit }

  opt.on("--update", "-u", "Updates the page cache") { update_pages_opt(parent_directory) ; exit}
end.parse!
