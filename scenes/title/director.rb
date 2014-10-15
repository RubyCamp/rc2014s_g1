require_relative "botton"
require_relative "mouse"
require_relative "../../constant"

module Title
  class Director
    include SceneUtil
    include Constant
    
    def initialize
      @message = Font.new(32)
      @font = Font.new(32)
      @mark=[]
      @image=Image.load("images/ruby_proto.png")
      @point=Mouse.new(250,500,"images/ruby_proto.png")
      @bg_img = Image.load("images/background_title.png")
	@k=150
      @slow = Button.new(40,Window.height-@k,Constant::SLOW_SP,"images/slow03.png")
      @normal = Button.new(120,Window.height-@k,Constant::NORMAL_SP,"images/normal00.png")
      @fast = Button.new(220,Window.height-@k,Constant::FAST_SP,"images/fast.png")
      @mark << @slow
      @mark << @normal
      @mark << @fast
      @mark << @point
    end
    
    def play
      Window.draw(0, 0, @bg_img)
      Sprite.draw([@slow,@fast,@normal,@point])
      Window.draw_font(430,75,"SpaceKeyでスタート",@message)
      str="NORMAL"
      case $speed_ruby
      when Constant::SLOW_SP
        str="SLOW"
      when Constant::NORMAL_SP
        str="NORMAL"
      when Constant::FAST_SP 
        str="FAST"
      end
      
      Window.draw_font(120,550,str,@font)
      x=Input.mouse_pos_x
      y=Input.mouse_pos_y
      @point.update([x,y])
      if Input.mouse_push?(M_LBUTTON)
        Sprite.check(@mark)
      end
    end
  end
end
