#!/usr/bin/env ruby
load "SFO.rb"
#require "bindata"
require "http"

def read_data(f)
  #puts "Open"
  count = 0
  while record = f.read(1024)
    count += record.length
    if (found = /\000PSF/.match(record)) != nil
    then
      #puts "Found SFO magic at #{count}"
      f.seek(found.begin(0) - 1024, IO::SEEK_CUR)
      res = SFO::parse_sfo(f)
      #puts res
      if (res != nil)
      then
        return res
      end
    end
  end
  #puts 'Nothing found'
end

def get_sfo_from_pkg(url)
  #puts "Requesting #{url}"
  if (url.include? 'http')
  then
    f = StringIO.new
    body = HTTP.get(url).body
    while((tmp = body.readpartial) != nil && f.length <= 1024*1024*2)
      f << tmp
    end
    f.seek(0)
    read_data(f)
  else
    open(url, 'r') do |f|
      read_data(f)
    end
  end
end

sfo = get_sfo_from_pkg ARGV[0]
puts "Title ID #{sfo[:TITLE_ID].to_binary_s}"
puts "PS4 System Version #{sfo[:SYSTEM_VER].to_binary_s.reverse.unpack('H*')}"
