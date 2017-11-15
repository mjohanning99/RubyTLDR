#!/bin/env ruby

#The option parser that parses the "--help", "--list" and "--update" options, most of which don't work anymore after the restructuring.
#TODO Rewrite option parser using ARGV[0] instead
OptionParser.new do |opt|
  opt.on("--help", "-h") { puts "HELP:".colorize(:background => :green) + " To display a tldr page, write 'tldr' followed by the command you want to have explained.\nWords surrounded by '<>' are files / commands the user needs to add themselves.\nTo get a list of the available commands, you can run 'tldr --list'. I would recommend using it in conjuction with a unix pipeline like so: 'tldr --list | sort | less'\nTo update the list of pages, you can run tldr --update\nTo get even more information about this program, please refer to the README file located in #{File.expand_path('../..', File.dirname(__FILE__))}" ; $optparse = true}
  opt.on("--list", "-l") { puts Dir.entries(@linux) ; $optparse = true }
  opt.on("--update", "-u") { `bash #{@parent_directory}/bin/update_pages.sh` ; exit }
end.parse!
