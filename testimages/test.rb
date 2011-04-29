#!/usr/bin/ruby

require 'rubygems'
require 'rmagick'

width =  480
height = 154

f = File.open('veh_bkgnd_VW_daytime.dat','rb').read

z = 16

data = Array.new(height) {
  Array.new(width) {
  z += 1
    [f[z],f[z],f[z]]
    
  }
}

img = Magick::Image.new(width/2, height)

data.each_with_index do |row, row_index|
  row.values_at(* row.each_index.select {|i| i.odd?}).each_with_index do |item, column_index|

#  row.each_with_index do |item, column_index|
    img.pixel_color(column_index, height-1-row_index, "rgb(#{item.join(', ')})")
  end
end

img.write('demo.png')

