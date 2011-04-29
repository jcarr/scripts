#!/usr/bin/ruby

require 'rubygems'
require 'rmagick'

width = 154
height = 480

f = File.open('veh_bkgnd_VW_daytime.dat','rb').read

z = 16

data = Array.new(width) {
  Array.new(height) {
  z += 1
    [f[z],f[z],f[z]]
    
  }
}

p data

img = Magick::Image.new(width, height)

data.each_with_index do |row, row_index|
  row.each_with_index do |item, column_index|
    img.pixel_color(row_index, column_index, "rgb(#{item.join(', ')})")
  end
end

img.write('demo.png')

