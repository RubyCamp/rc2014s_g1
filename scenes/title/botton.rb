class Button  < Sprite
  def initialize(x,y,speed,imagefile=nil)
    @speed=speed
    image=Image.load(imagefile)
    super(x,y,image)
    @select_music = Sound.new("bgm/select.wav")
  end
  def hit(obj)
    $speed_ruby=@speed
    p "speed_chage"
    @select_music.play
  end
end
