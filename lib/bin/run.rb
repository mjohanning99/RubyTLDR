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

#Checking if the page exists, parsing it using parse_md and downloading it if necessary
def run()
  begin
    page = "#{ARGV[0].downcase}.md"
  rescue NoMethodError
    puts "ERROR!".colorize(:background => :red) + " You need to append an argument to the file to display the tldr (Please use tldr --help for more information)"
    exit
  end
  case operating_system()
  when "linux"
    parse_md(@linux, page)
  when "common"
    parse_md(@common, page)
  when "windows"
    parse_md(@windows, page)
  when "osx"
    parse_md(@osx, page)
  when "sunos"
    parse_md(@sunos, page)
  when "nil"
    puts "ERROR!".colorize(:background => :red) + " You need to append an argument to the file to display the tldr (Please use tldr --help for more information)"
  else
    puts "ERROR!".colorize(:background => :red) + " There was no tldr page found for the command '#{ARGV[0]}'"
    puts "We are now updating the page cache, please wait"
    update_pages()
    puts "SUCCESS!".colorize(:background => :green, :color => :black) + " The page cache has been updated successfully."
  end
end
