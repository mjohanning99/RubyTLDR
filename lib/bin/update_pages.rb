#!/bin/env ruby
# coding: utf-8

#This is the method that will update the page cache so that the pages are up-to date [.zip file, checking the Github folders or downloading the .json file
def update_pages()
  #Check for internet connection (and connection to tldr.sh for assets)
  puts "Checking connection to https://tldr.sh ..."
  begin
    TCPSocket.new 'tldr.sh', 443
  rescue SocketError
    puts "ERROR".colorize(:background => :red) + " An error occurred whilst updating the page cache. Please check your internet connection [SocketError]"
    exit
  end

  puts "Connection has been established. Checking if #{ARGV[0]} is available."

  #Downloading index.json from tldr.sh and checking if the entered command exists
  File.open("#{@parent_directory}/index.json", "wb") do |saved_file|
    URI.open("https://tldr.sh/assets/index.json", "r") do |read_file|
      saved_file.write(read_file.read)
    end
  end
  index = File.read("#{@parent_directory}/index.json")
  if index.include?(ARGV[0]) then
    puts "#{ARGV[0]} has been found, now updating page cache. Please wait ..."
    FileUtils.rm_rf("#{@parent_directory}/pages")
    File.open("#{@parent_directory}/pages.zip", "wb") do |saved_file|
      URI.open("https://tldr.sh/assets/tldr.zip", "r") do |read_file|
        saved_file.write(read_file.read)
      end
    end
    extract_zip("#{@parent_directory}/pages.zip", "#{@parent_directory}")
    FileUtils.rm("#{@parent_directory}/pages.zip")
  else
    puts "ERROR:".colorize(:background => :red) + " Page could not be found in database – Not updating cache"
    FileUtils.rm_rf("#{@parent_directory}/index.json")
    exit
  end
end

def update_pages_opt(parent_directory)
  puts "Checking connection to https://tldr.sh ..."
  #Check for internet connection (and connection to tldr.sh for assets)
  begin
    TCPSocket.new 'tldr.sh', 443
  rescue SocketError
    puts "ERROR".colorize(:background => :red) + " An error occurred whilst updating the page cache. Please check your internet connection [SocketError]"
    exit
  end

  puts "Connection has been established. Pages are being updated, please wait ..."

  FileUtils.rm_rf("#{parent_directory}/pages")
  File.open("#{parent_directory}/pages.zip", "wb") do |saved_file|
    URI.open("https://tldr.sh/assets/tldr.zip", "r") do |read_file|
      saved_file.write(read_file.read)
    end
  end
  extract_zip("#{parent_directory}/pages.zip", "#{parent_directory}")
  FileUtils.rm("#{parent_directory}/pages.zip")

  puts "Pages have sucessfully been updated."
end
