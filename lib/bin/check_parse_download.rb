#!/bin/env ruby
#Checking if the page exists, parsing it using parse_md and downloading it if necessary

def check_parse_download(directory)
  if Dir.entries(directory).include?("#{ARGV[0]}.md") then
    begin
      Dir.entries(directory).each do |page|
        if page == ARGV[0] + ".md" then
          parse_md(directory, page)
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
        `rm -rf #{@parent_directory}/pages/commonlinux/#{ARGV[0]}.md`
      end
    end
  end
end
