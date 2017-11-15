#!/bin/env ruby
#Checks where the page exists in the page folders

def page_exist_where()
  return "linux" if Dir.entries(@linux).include?("#{ARGV[0]}.md")
  return "common" if Dir.entries(@common).include?("#{ARGV[0]}.md")
  return "windows" if Dir.entries(@windows).include?("#{ARGV[0]}.md")
  return "osx" if Dir.entries(@osx).include?("#{ARGV[0]}.md")
  return "sunos" if Dir.entries(@sunos).include?("#{ARGV[0]}.md")
  return "nil" if ARGV[0].class == NilClass
end
