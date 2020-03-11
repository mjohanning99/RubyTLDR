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

#Pages
@parent_directory = File.expand_path('..', File.dirname(__FILE__))
@linux = "#{@parent_directory}/pages/linux"
@common = "#{@parent_directory}/pages/common"
@windows = "#{@parent_directory}/pages/windows"
@sunos = "#{@parent_directory}/pages/sunos"
@osx = "#{@parent_directory}/pages/osx"

def clear_screen()
	print "\e[H\e[2J"
end

#Checking if the page exists, parsing it using parse_md and downloading it if necessary
def run(os)
	clear_screen()
	if ARGV.size == 1 && os == false then
		begin
			page = "#{ARGV[0].downcase}.md"
		rescue NoMethodError
			puts "ERROR!".colorize(:background => :red) + " You need to append an argument to the file to display the tldr (Please use tldr --help for more information)"
			exit
		end

		case operating_system()
		when "linux"
			puts @linux
			parse_md(@linux, page, false)

		when "common"
			parse_md(@common, page, false)

		when "windows"
			parse_md(@windows, page, false)

		when "osx"
			parse_md(@osx, page, false)

		when "sunos"
			parse_md(@sunos, page, false)

		when "nil"
			puts "ERROR!".colorize(:background => :red) + " You need to append an argument to the file to display the tldr (Please use tldr --help for more information)"
		else
			puts "ERROR!".colorize(:background => :red) + " There was no tldr page found for the command '#{ARGV[0]}'"
			puts "We are now updating the page cache, please wait"
			update_pages()
			puts "SUCCESS!".colorize(:background => :green, :color => :black) + " The page cache has been updated successfully."
		end

		else
			begin
				page = "#{ARGV[1].downcase}.md"
			rescue NoMethodError
				puts "ERROR!".colorize(:background => :red) + " You need to append an argument to the file to display the tldr (Please use tldr --help for more information)"
				exit
			end

			begin
				case os
				when "linux"
						puts @linux
						parse_md(@linux, page, true)

				when "common"
						parse_md(@common, page, true)

				when "windows"
						parse_md(@windows, page, true)

				when "osx"
						parse_md(@osx, page, true)

				when "sunos"
						parse_md(@sunos, page, true)

				when "nil"
					puts "ERROR!".colorize(:background => :red) + " You need to append an argument to the file to display the tldr (Please use tldr --help for more information)"
				end

			rescue Errno::ENOENT
				puts "ERROR!".colorize(:background => :red) + " There was no tldr page found for the command '#{ARGV[1]}' and the platform '#{ARGV[0]}'"
				puts "We are now updating the page cache, please wait"
				update_pages()
				puts "SUCCESS!".colorize(:background => :green, :color => :black) + " The page cache has been updated successfully."
			end
		end
end

