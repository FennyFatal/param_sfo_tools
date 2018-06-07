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
    tries = 0;
    while (f.length == 0 && tries < 5)
      tries += 1;
      body = HTTP.get(url).body
      while((tmp = body.readpartial) != nil && f.length <= 1024*1024*10)
        f << tmp
      end
    end
    f.seek(0)
    puts f.length
    read_data(f)
  else
    open(url, 'r') do |f|
      read_data(f)
    end
  end
end

sfo = get_sfo_from_pkg ARGV[0]
sfo.each_pair do |key,value|
  puts "#{key}: #{value}"
end
