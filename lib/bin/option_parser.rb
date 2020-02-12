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

parent_directory = File.expand_path('..', File.dirname(__FILE__))
OptionParser.new do |opt|

  #The default 'banner' that gets displayed when running rtldr --help
  opt.banner =
    "RubyTldr".bold() + " (rtldr) is a program that will show you man-pages that have been condensed down to the most important information and are thus much easier to read and comprehend.\n" \
    "If you wish to see the tldr-page of a particular command / program, simply write 'rtldr' followed by the command you wish to see the tldr-page of (for example, " + "rtldr tar".bold() + ").\n" \
    "The text displayed inbetween <> is to be replaced by you according your specific needs; you may have to enter specific file name, such as in the following example: " + "'tar cf <target.tar>'".bold() + " wherein you will need to replace the " + "'<target.tar>'".bold() + " with your specific tar file (" + "tar cf my_archive.tar".bold() + ") for example.\n\n"
    "Usage: ".bold() + "rtldr".underline() + " [options]" + "\n"

  #Printing the help information of every command
  opt.on("--help", "-h", "Prints this help") do
    puts opt
    exit
  end

  #Listing every available command
  opt.on("--list", "-l", "Lists all the available commands") { puts Dir.entries("#{parent_directory}/pages/linux") ; puts Dir.entries("#{parent_directory}/pages/common") ; puts Dir.entries("#{parent_directory}/pages/windows") ; puts Dir.entries("#{parent_directory}/pages/osx") ; puts Dir.entries("#{parent_directory}/pages/sunos") ; exit }

  #Updating the pages
  opt.on("--update", "-u", "Updates the page cache") { update_pages_opt(parent_directory) ; exit}
end.parse!
