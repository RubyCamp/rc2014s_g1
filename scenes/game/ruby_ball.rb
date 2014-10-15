# encoding : UTF-8
class Ball < Sprite
	@count = 0
	@@shot = Sound.new("bgm/shot.wav")
	def self.count
		@count ||= 0
		return @count
	end
	def self.count_up
		@count ||= 0
		@count +=1
	end
	def self.count_down
		@count ||= 1
		@count += -1
	end
	def initialize(x, y, speed, image = nil) #speedは＋で右向き、-にすると左向き
		super(x, y, image)
		@sp_x = speed
		@sp_y = 0
		self.class.count_up
	end
	def update
		self.x += @sp_x
		self.y += @sp_y
		if self.x > Window.width || self.x < 0
			self.vanish
		end
	end
	def hit(obj)
		self.vanish
		if obj.is_a? self.class
			obj.vanish
		end
	end
	def shot(obj)
		@@shot.play
		self.vanish
	end
	def vanish
		self.class.count_down
		super
	end
	def self.reset_count
		@count = 0
	end
end

class Ruby_ball < Ball
	@@image = Image.load("images/ruby.png")
	def initialize(x, y, speed) #speedは＋で右向き、-にすると左向き
		super(x, y, speed, @@image)
	end
end

class Diamond_ball < Ball
	@@image = Image.load("images/dia.png")
	def initialize(x, y, speed) #speedは＋で右向き、-にすると左向き
		super(x, y, speed, @@image)
	end
end

class SuperRuby_ball < Ball
	@@image = Image.load("images/super_ruby.png")
	def initialize(x, y, speed) #speedは＋で右向き、-にすると左向き
		super(x, y, speed, @@image)
	end
	def hit(obj)
		if obj.is_a? SuperDiamond_ball
			self.vanish
			obj.vanish
		end
		if obj.is_a? Wall
			self.vanish
		end
	end
	def shot(obj)
		if obj.is_a? SuperDiamond_ball
			self.vanish
			obj.vanish
		end
		if obj.is_a? Wall
			self.vanish
		end
	end
	def vanish
		if self.x >= 0 && self.x <= Window.width
			$collision << Effect.new(self.x, self.y)
		end
		super
	end
end

class SuperDiamond_ball < Ball
	@@image = Image.load("images/super_dia.png")
	def initialize(x, y, speed) #speedは＋で右向き、-にすると左向き
		super(x, y, speed, @@image)
	end

	def hit(obj)
		if obj.is_a? SuperRuby_ball
			self.vanish
			obj.vanish
		end
		if obj.is_a? Wall
			self.vanish
		end
	end
	def shot(obj)
		if obj.is_a? SuperRuby_ball
			self.vanish
			obj.vanish
		end
		if obj.is_a? Wall
			self.vanish
		end
	end
	def vanish
		if self.x >= 0 && self.x <= Window.width 
			$collision << Effect.new(self.x, self.y)
		end
		super
	end
end
