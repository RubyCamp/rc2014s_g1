#衝突エフェクト
class Effect < Sprite
	@@image = Image.load("images/effect.png")
	def initialize(x, y)
		super(x, y, @@image)
		@count = 60
		self.collision_enable = false #衝突判定を無効に
		@played = false
		@break_sound = Sound.new("bgm/super_break.wav")
	end
	
	def sound_played
		unless @played
			@break_sound.setVolume( 255 )
			@break_sound.play
			@played = true
		end
	end
	
	def update
		self.sound_played
		@count += -1
		if @count <= 0
			vanish
		end
	end
end
