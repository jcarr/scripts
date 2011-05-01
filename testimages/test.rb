#!/usr/bin/ruby

require 'rubygems'
require 'rmagick'

d = File.open('veh_bkgnd_VW_daytime.dat','rb').read

unknown, imagesize, width, height = d[0..15].unpack('NNNN')

puts "image size = #{width}x#{height}"

imagedata = d[16..-1]

raise "image incorrect size" unless imagedata.length == height*width*2

img = Magick::Image.new(width, height)

height.times { |y|
  width.times { |x|
    index=(y*width+x)*2
    puts "@#{x},#{y} #{index}"
    
    if index+2 > imagedata.length
      puts "shit is too long"
      next
    end
    
    pix = imagedata[index..index+2]
    
    ph = pix.unpack('n')[0]
        
    r = ((ph >> 10) & 0x1f) << 3
    g = ((ph >>  5) & 0x1f) << 3
    b = ((ph >>  0) & 0x1f) << 3
    
    rgb = "rgb(#{r},#{g},#{b})"
    
    puts "#{ph} - @#{x}x#{y} #{rgb}"
    
    img.pixel_color(x,height-y-1,rgb)
  }
}

img.write('demo.png')

