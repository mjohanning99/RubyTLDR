#!/bin/env ruby

require 'open-uri'
@parent_directory = File.expand_path('..', File.dirname(__FILE__))

def download_page_linux(page)
  File.open("#{@parent_directory}/pages/commonlinux/#{page}.md", "wb") do |saved_file|
    open("https://raw.githubusercontent.com/tldr-pages/tldr/master/pages/linux/#{page}.md", "r") do |read_file|
      saved_file.write(read_file.read)
    end
  end
end

def download_page_common(page)
  File.open("#{@parent_directory}/pages/commonlinux/#{page}.md", "wb") do |saved_file|
    open("https://raw.githubusercontent.com/tldr-pages/tldr/master/pages/common/#{page}.md", "r") do |read_file|
      saved_file.write(read_file.read)
    end
  end
end
