require 'dxruby'

Window.caption = "Ruby Throw"
Window.width   = 800
Window.height  = 600

require_relative 'scene'
require_relative 'scenes/load_scenes'
require_relative "constant"


$speed_ruby=Constant::NORMAL_SP

Scene.set_current_scene(:title)

$winner=0
HPCONST=15
GAGEMID = 10
GAGEMAX = 50
GAGEURAMAX = 200
$collision=[]
$white_wins = 0
$black_wins = 0

Window.loop do
  break if Input.keyPush?(K_ESCAPE) 
   if Input.keyPush?(K_SPACE)
      Scene.set_current_scene(:game) 
  end 
  Scene.play_scene
end
