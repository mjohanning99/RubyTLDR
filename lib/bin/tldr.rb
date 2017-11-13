#!/bin/env ruby

#Gems
require 'colorize'
require 'redcarpet'
require 'redcarpet/render_strip'

#Pages
@lcpages = "./lib/pages/commonlinux"

#Option Parser
Dir.entries(@lcpages).each do |page|
  if page == ARGV[0] + ".md" then
    File.open("#{@lcpages}/#{page}").each_line do |line|
      puts line.colorize(:color => :black, :background => :red) if /^#/ =~ line
      puts line.colorize(:yellow) if /^>/ =~ line
      puts line.colorize(:green) if /^-/ =~ line
      puts line if /^`/ =~ line
    end
  end
end
