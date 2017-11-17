#!/bin/env ruby

#This is the method that will update the page cache so that the pages are up-to date [.zip file, checking the Github folders or downloading the .json file
def update_pages()
  FileUtils.rm_rf("#{@parent_directory}/pages")
  File.open("#{@parent_directory}/pages.zip", "wb") do |saved_file|
    open("https://tldr.sh/assets/tldr.zip", "r") do |read_file|
      saved_file.write(read_file.read)
    end
  end
  extract_zip("#{@parent_directory}/pages.zip", "#{@parent_directory}")
  FileUtils.rm("#{@parent_directory}/pages.zip")
end
