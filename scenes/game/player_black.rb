class Player_black < Sprite
	
	IMAGE = Image.load("images/playerblack.png")	
	def initialize(x, y, image = nil)
		image = IMAGE
		image.set_color_key([0, 0, 0])
		@sound = Sound.new("bgm/throw.wav")
		@super_sound = Sound.new("bgm/ougi.wav")
		@gage = 0
		@charge = Sound.new("bgm/charge.wav")
		@music_start = 0
		super
	end
	
	def gage
		@gage
	end
	
	def chargestop
		@charge.stop
	end
	
	def throw_ruby(spd)
		if(@gage < GAGEMID)
			@sound.play
			@gage = 0
			@charge.stop
			@music_start = 0
			return Ruby_ball.new(self.x, self.y, -spd)
		elsif(@gage < GAGEMAX)
			@sound.play
			@gage = 0
			@charge.stop
			@music_start= 0
			return [Ruby_ball.new(self.x, self.y + 30, -spd),Ruby_ball.new(self.x, self.y - 30, -spd)]
		elsif(@gage < GAGEURAMAX)
			@super_sound.setVolume(255)
			@super_sound.play
			@gage = 0
			@charge.stop
			@music_start = 0
			return SuperRuby_ball.new(self.x, self.y, -spd * 2)
		else
			@super_sound.setVolume(255)
			@super_sound.play
			@gage = 0
			@charge.stop
			@music_start = 0
			return [SuperRuby_ball.new(self.x, self.y - 60, -spd * 2), SuperRuby_ball.new(self.x, self.y - 30, -spd * 2), SuperRuby_ball.new(self.x, self.y, -spd * 2), SuperRuby_ball.new(self.x, self.y + 30, -spd * 2), SuperRuby_ball.new(self.x, self.y + 60, -spd * 2)]
		end
	end
	
	def initplayer
		self.x = Window.width-45
		self.y = Window.height/2
	end
	
	def update
		self.y += Input.y * 10 if (self.y < (Window.height - self.image.height) && Input.y > 0) || (self.y - 70 > 0 && Input.y < 0)
		if(Input.key_down?(K_P))
			if(@music_start == 0)
				@charge.setVolume( 255 )
				@charge.play
				@music_start = 1
			end
			@gage += 1
		else
			@gage = 0
		end
	end
end
