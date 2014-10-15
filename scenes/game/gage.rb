# -*- coding: utf-8 -*-
class Gage_left
  def initialize(x, y, width, height, margin, frame_color, bar_color, back_color) # colorは[0, 0, 0]のような数字の配列 frameは枠、backは枠内の背景の色
		#marginはframeとbarの間の余白
		@x = x
		@y = y
		@width = width
		@height = height
		@margin = margin
		@bar_color = bar_color
		@frame_color = frame_color
		@back_color = back_color
		@gage = Image.new(@width, @height, @back_color)
  end

	def update(percentage)
		@gage.boxFill(0, 0, @width, @height, @back_color)
		@gage.box(0, 0, @width, @height, @frame_color)
		@gage.boxFill(@margin, @margin, (@width - @margin * 2) * percentage * 0.01, @height - @margin * 2, @bar_color)
	end
  
  def draw
		Window.draw(@x, @y, @gage)
  end
end

class Gage_right < Gage_left
	def update(percentage)
		@gage.boxFill(0, 0, @width, @height, @back_color)
		@gage.box(0, 0, @width, @height, @frame_color)
		@gage.boxFill((100 - percentage) * 0.01 * (@width - @margin), @margin, @width, @height - @margin * 2, @bar_color)
	end
end

