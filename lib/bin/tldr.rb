#!/bin/env ruby

#Checking platform
unless /linux/ =~ RUBY_PLATFORM then
  puts "Only Linux is supported currently"
  exit
end

#Gems and other files
require 'optparse'
require_relative 'download_new_pages.rb'

begin
  require 'colorize'
rescue LoadError
  `gem install colorize`
  puts "You did not have the colorize gem installed when starting this program. We tried installing it, please run the program again and see if it works correctly. If it does not, please create an issue on this project't Github repository"
  exit
end

#Predefined variables
options = {}
@optparse = false

#Pages
parent_directory = File.expand_path('..', File.dirname(__FILE__))
@lcpages = "#{parent_directory}/pages/commonlinux"

#Option Parser
OptionParser.new do |opt|
  opt.on("--help", "-h") { puts "HELP:".colorize(:background => :green) + " To display a tldr page, write 'tldr' followed by the command you want to have explained. To get a list of the available commands, you can run 'tldr --list'. I would recommend using it in conjuction with a unix pipeline like so: 'tldr --list | sort | less'\n" ; @optparse = true}
  opt.on("--list", "-l") { puts Dir.entries(@lcpages) ; @optparse = true }
end.parse!

#Getting user input and displaying / formatting output
`rm -rf #{@lcpages}/#{ARGV[0]}.md` if File.zero?("#{@lcpages}/#{ARGV[0]}.md")

#if Dir.entries(@lcpages).include?(ARGV[0] + ".md") then
  begin
    Dir.entries(@lcpages).each do |page|
      if page == ARGV[0] + ".md" then
        #TODO Create seperate method for parsing the .md files
        File.open("#{@lcpages}/#{page}").each_line do |line|
          puts line.gsub(/#/, "---->").colorize(:color => :black, :background => :red) if /^#/ =~ line
          puts line.colorize(:yellow) if /^>/ =~ line
          puts line.gsub(/\n/, "").colorize(:green) if /^-/ =~ line
          puts line.gsub(/\{/, "").gsub(/\}/, "").gsub(/`/, "").colorize(:color => :black, :background => :blue)+ "\n" if /^`/ =~ line
        end
      end
    end
  rescue NoMethodError
    puts "ERROR:".colorize(:background => :red) + " You need to append an argument to the file to display the tldr (Please use tldr --help for more information) [NoMethodError]" unless @optparse
  end
else
  puts "Page '#{ARGV[0]}' not found... trying to download"
  begin
    download_page_linux(ARGV[0])
    puts "Please try running the command again"
  rescue
    begin
      download_page_common(ARGV[0])
      puts "Please try running the command again"
    rescue
      puts "Page #{ARGV[0]} could not be found on the servers"
    end
  end
end
