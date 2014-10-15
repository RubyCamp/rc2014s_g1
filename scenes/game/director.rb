# -*- coding: utf-8 -*-

require_relative 'player_black'
require_relative 'player_white'
require_relative 'ruby_ball'
require_relative 'wall'
require_relative 'effect'
require_relative 'gage'

module Game
	class Director
		GAGEWIDTH = 200
		GAGEHIGHT = 20
		MARGIN = 2

		def initialize
@font = Font.new(32)
@blackboard = Image.new(Window.width - GAGEWIDTH * 2 - 50, 50, [50, 255, 50])
			@player_white= Player_white.new(150,Window.height/2)
			@player_black= Player_black.new(Window.width-205,Window.height/2)
			@wall1= Wall.new(20,500)
			@wall2= Wall.new(Window.width - 60,0)
			@rubies1=[]
			@rubies2=[]

			@winner = nil

			@hpgage_white = Gage_left.new(10, 10, GAGEWIDTH, GAGEHIGHT, MARGIN, [0, 0, 0], [204, 0, 0], [255, 255, 255])
			@hpgage_black = Gage_right.new(Window.width - GAGEWIDTH - 10, 10, GAGEWIDTH, GAGEHIGHT, 2, [0, 0, 0], [204, 0, 0], [255, 255, 255])
			@chargegage_white = Gage_left.new(10, 40, GAGEWIDTH, GAGEHIGHT, MARGIN, [0, 0, 0], [204, 204, 0], [255, 255, 255])
			@chargegage_black = Gage_right.new(Window.width - GAGEWIDTH - 10, 40, GAGEWIDTH, GAGEHIGHT, 2, [0, 0, 0], [204, 204, 0], [255, 255, 255])


			@rubies1=[]
			@rubies2=[]

			@bg_img = Image.load("images/field.png")
			# @@s=10
			@win_player_black_img = Image.load("images/win_black.png")
			@win_player_white_img = Image.load("images/win_white.png")
			@bgm = Sound.new("bgm/activity of future-town.mid")
			@start_voice = Sound.new("bgm/start.wav")
			@passing_frames = 0
			@finish_music = Sound.new("bgm/finish.wav")
			@played = false
			@finish_whistle = Sound.new("bgm/whistle.wav")
		end

		def finish_voice
			unless @played
				@finish_whistle.setVolume( 255 )
				@finish_whistle.play
				@finish_whistle.stop
				@finish_music.setVolume( 255 )
				@finish_music.start=80000
				@finish_music.play
				@played = true
			end
		end

		def play
			if @winner
				if @winner.is_a? Player_white
					Window.draw(0,0,@win_player_white_img,100)      
				elsif @winner.is_a? Player_black
					Window.draw(0,0,@win_player_black_img,100)
				end

				self.finish_voice

				if(Input.keyPush?(K_SPACE))
					if @winner.is_a? Player_white
						$white_wins += 1
					elsif @winner.is_a? Player_black
						$black_wins += 1
					end
					Window.draw_font(GAGEWIDTH + 50, 320, $white_wins.to_s, @font)
					Window.draw_font(Window.width - GAGEWIDTH - 50, 320, $black_wins.to_s, @font)
					Scene.set_current_scene(:title) 
					Scene.delete_scene(:game)
					Scene.add_scene(Game::Director.new, :game)
					[Ruby_ball, Diamond_ball, SuperRuby_ball, SuperDiamond_ball].each(&:reset_count)
					$collision = []
				end 

			else

				# キャラクター1の移動
				if Diamond_ball.count <= 4
					if Input.keyRelease?(K_D)
						@rubies1 << @player_white.throw_ruby($speed_ruby) 
						@rubies1.flatten!
					end
				end

				# キャラクター2の移動
				if Ruby_ball.count <= 4
					if Input.keyRelease?(K_P)
						@rubies2 << @player_black.throw_ruby($speed_ruby) 
						@rubies2.flatten!
					end
				end
				
				Sprite.update([@player_white,@player_black,@rubies1,@rubies2,@wall1,@wall2])       
				Sprite.check(@rubies1,@rubies2)
				Sprite.check(@rubies1,@wall2)
				Sprite.check(@rubies2,@wall1)
				Sprite.update($collision)
				@hpgage_white.update((HPCONST - @wall1.count) * 100 / HPCONST)
				@hpgage_black.update((HPCONST - @wall2.count) * 100 / HPCONST)
				@chargegage_white.update(@player_white.gage * 100 / GAGEMAX.to_f)
				@chargegage_black.update(@player_black.gage * 100 / GAGEMAX.to_f)
				if(@passing_frames == 0)
					@start_voice.play
				elsif(@passing_frames == 2 * Window.fps)
					@bgm.setVolume(255)
					@bgm.play
				end    
				@passing_frames += 1
				if(@wall1.count>=HPCONST)
					@bgm.stop
					@player_white.chargestop
					@player_black.chargestop
					p "player_black win."
					@winner = @player_black
				end        
				if(@wall2.count>=HPCONST)
					@bgm.stop
					@player_white.chargestop
					@player_black.chargestop
					p "player_white win."
					@winner = @player_white      
				end
			end

			Window.draw(0,0,@bg_img)
			Sprite.draw([@player_white,@player_black,@wall1,@wall2,@rubies1,@rubies2]) 
			Sprite.draw($collision)
			@hpgage_white.draw
			@hpgage_black.draw
			@chargegage_white.draw
			@chargegage_black.draw
			Window.draw(GAGEWIDTH + 20, 20, @blackboard)
			Window.draw_font(GAGEWIDTH + 50 - 16, 30, $white_wins.to_s, @font)
			Window.draw_font(Window.width - GAGEWIDTH - 50 - 16, 30, $black_wins.to_s, @font)
			Window.draw_font((Window.width) / 2 - 16, 30, "VS", @font)
		end
	end
end
