#!/bin/env ruby
# coding: utf-8

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

#This is the method that will update the page cache so that the pages are up-to date [.zip file, checking the Github folders or downloading the .json file
def update_pages()
  #Check for internet connection (and connection to tldr.sh for assets)
  puts "Checking connection to https://tldr.sh ..."
  begin
    TCPSocket.new 'tldr.sh', 443
  rescue SocketError
    puts "ERROR!".colorize(:background => :red) + " An error occurred whilst updating the page cache. Please check your internet connection [SocketError]"
    exit
  end

  puts "SUCCESS!".colorize(:background => :green, :color => :black) + " Connection has been established. Checking if '#{ARGV[0]}' is available."

  #Downloading index.json from tldr.sh and checking if the entered command exists
  File.open("#{@parent_directory}/index.json", "wb") do |saved_file|
    URI.open("https://tldr.sh/assets/index.json", "r") do |read_file|
      saved_file.write(read_file.read)
    end
  end

  #Reading the index.json
  index = File.read("#{@parent_directory}/index.json")
  #And parsing it using Ruby's inbuilt JSON parser
  index_parsed = JSON.parse(index)

  #Check every available command in the .json file, compare it to ARGV[0] and if it matches, set the @found variable to 'true' and break out of the loop
  index_parsed["commands"].each do |name|
    if name["name"].to_s.chomp == ARGV[0].downcase.chomp then
      @found = true
      break
    else
      @found = false
    end
  end

  #Update page cache if the @found variable is set to 'true', i. e. if ARGV[0] could be found inside of the downloaded .json file
  if @found == true then
    puts "'#{ARGV[0]}' has been found, cache is being updated. Please wait ..."
    FileUtils.rm_rf("#{@parent_directory}/pages")
    File.open("#{@parent_directory}/pages.zip", "wb") do |saved_file|
      URI.open("https://tldr.sh/assets/tldr.zip", "r") do |read_file|
        saved_file.write(read_file.read)
      end
    end
    extract_zip("#{@parent_directory}/pages.zip", "#{@parent_directory}")
    FileUtils.rm("#{@parent_directory}/pages.zip")
    FileUtils.rm("#{@parent_directory}/index.json")
  else
    puts "ERROR!".colorize(:background => :red) + " Page could not be found in database – Not updating cache"
    FileUtils.rm("#{@parent_directory}/index.json")
    exit
  end
end


def update_pages_opt(parent_directory)
  puts "Checking connection to https://tldr.sh ..."
  #Check for internet connection (and connection to tldr.sh for assets)
  begin
    TCPSocket.new 'tldr.sh', 443
  rescue SocketError
    puts "ERROR!".colorize(:background => :red) + " An error occurred whilst updating the page cache. Please check your internet connection [SocketError]"
    exit
  end

  puts "SUCCESS!".colorize(:background => :green, :color => :black) + " Connection has been established. Pages are being updated, please wait ..."

  FileUtils.rm_rf("#{parent_directory}/pages")
  File.open("#{parent_directory}/pages.zip", "wb") do |saved_file|
    URI.open("https://tldr.sh/assets/tldr.zip", "r") do |read_file|
      saved_file.write(read_file.read)
    end
  end
  extract_zip("#{parent_directory}/pages.zip", "#{parent_directory}")
  FileUtils.rm("#{parent_directory}/pages.zip")
  FileUtils.rm("#{parent_directory}/index.json")

  puts "SUCCESS!".colorize(:background => :green, :color => :black) + " Pages have sucessfully been updated."
end
