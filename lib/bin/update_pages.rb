#!/bin/env ruby

#This is the method that will update the page cache so that the pages are up-to date [.zip file, checking the Github folders or downloading the .json file
require 'open-uri'
def update_pages()
  File.open("#{File.expand_path('..', File.dirname(__FILE__))}/pages.zip", "wb") do |saved_file|
    open("https://tldr.sh/assets/tldr.zip", "r") do |read_file|
      saved_file.write(read_file.read)
    end
  end
end
update_pages()
