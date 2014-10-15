class Wall < Sprite
  def initialize(x,y,image = nil)
    image=Image.load("images/ss_wall.png")
#    image.set_color_key([0, 0, 0])
    @count = 0
    super
    @dy = 1
  end
  
  def count
    @count 
  end
  
  def initCount
  	  @count = 0
  end
  
  def update
      self.y +=  @dy * 5
      if   self.y - 75 < 0
	@dy = -@dy
	self.y = 75
      end      
      if  self.y > (Window.height - self.image.height)
         @dy = -@dy
         self.y = Window.height - self.image.height
      end
       @dy = -@dy if rand(100) > 95
  end

  def hit(obj)
    if(obj.is_a?(SuperRuby_ball) || obj.is_a?(SuperDiamond_ball))
  		@count += 5
    else
    	@count += 1
    end
    $winner = 1 if @count >= HPCONST
  end    
end
