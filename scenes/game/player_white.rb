class Player_white < Sprite
	
	IMAGE = Image.load("images/playerwhite.png")
	
	def initialize(x, y, image = nil)
		image = IMAGE
		image.set_color_key([0, 0, 0])
		@gage = 0
		@sound = Sound.new("bgm/throw.wav")
		@super_sound = Sound.new("bgm/ougi.wav")
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
	
	def initplayer
		self.x = 150
		self.y = Window.height/2
	end
	
	def throw_ruby(spd)
		if(@gage < GAGEMID)
			@sound.play
			@gage = 0
			@charge.stop
			@music_start = 0
			return Diamond_ball.new(self.x, self.y, spd)
		elsif(@gage < GAGEMAX)
			@sound.play
			@gage = 0
			@charge.stop
			@music_start = 0
			return [Diamond_ball.new(self.x, self.y + 30, spd),Diamond_ball.new(self.x, self.y - 30, spd)]
		elsif(@gage < GAGEURAMAX)
			@sound.play
			@gage = 0
			@charge.stop
			@music_start = 0
			return SuperDiamond_ball.new(self.x, self.y, spd * 2)
		else
			@super_sound.setVolume(255)
			@super_sound.play
			@gage = 0
			@charge.stop
			@music_start = 0
			return [SuperDiamond_ball.new(self.x, self.y - 60, spd * 2),SuperDiamond_ball.new(self.x, self.y - 30, spd * 2),SuperDiamond_ball.new(self.x, self.y, spd * 2),SuperDiamond_ball.new(self.x, self.y + 30, spd * 2),SuperDiamond_ball.new(self.x, self.y + 60, spd * 2)]
		end
	end
	
	def update
		(self.y += 10 if Input.keyDown?(K_S)) if self.y < (Window.height - self.image.height)
		(self.y -= 10 if Input.keyDown?(K_W)) if self.y - 70 > 0
		if(Input.key_down?(K_D))
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
