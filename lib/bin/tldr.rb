#!/bin/env ruby

#Gems
require 'redcarpet'
require 'redcarpet/render_strip'

#Pages
@lipages = Dir.entries("./lib/pages/linux")

#Option Parser
@lipages.each do |page|
  if page == ARGV[0] + ".md" then
    File.open("./lib/pages/linux/#{page}").each_line do |line|
      puts line
    end
  end
end
