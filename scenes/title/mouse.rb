class Mouse < Sprite
  def initialize(x,y,imagefile=nil)
    image=Image.load(imagefile)
    super(x,y,image)
  end
  def hit(obj)
  end
  def update(ary)
    self.x=ary[0]
    self.y=ary[1]
#    p [self.x,self.y]
  end
end
