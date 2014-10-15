require_relative 'scene_util'
require_relative 'game/director'
require_relative 'title/director'
#require_relative 'ending/director_black'
#require_relative 'ending/director_white'

Scene.add_scene(Title::Director.new,  :title)
Scene.add_scene(Game::Director.new,  :game)
#Scene.add_scene(Endingblack::Director.new, :endingblack)
#Scene.add_scene(Endingwhite::Director.new, :endingwhite)
