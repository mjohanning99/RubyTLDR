#!/bin/env ruby

=begin
Copyright 2017-2020 Marvin Johanning
This file is part of RubyTldr (rtldr).

RubyTldr is free software: you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation, either version 3 of the License, or
(at your option) any later version.

RubyTldr is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU General Public License for more details.

You should have received a copy of the GNU General Public License
along with RubyTldr.  If not, see <http://www.gnu.org/licenses/>.
=end

#Checks where the page exists in the page folders (and returns the operating system of the corresponding page)
def operating_system()
  return "linux" if Dir.entries(@linux).include?("#{ARGV[0]}.md")
  return "common" if Dir.entries(@common).include?("#{ARGV[0]}.md")
  return "windows" if Dir.entries(@windows).include?("#{ARGV[0]}.md")
  return "osx" if Dir.entries(@osx).include?("#{ARGV[0]}.md")
  return "sunos" if Dir.entries(@sunos).include?("#{ARGV[0]}.md")
  return "nil" if ARGV[0].class == NilClass
end
