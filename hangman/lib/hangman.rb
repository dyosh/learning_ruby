require "erb"

class Hangman
	def initialize
		@displayed_word = []
		@guessed_letters = ""
		@rnd_word = ""
		@max_guesses = 0
		@guesses_left = 6
		@playing_saved_game = false
		@@filename = ""
		self.word_from_file
		self.welcome_screen
	end

	def word_from_file
		if File.exist? "word_list.txt"
			words = File.readlines "word_list.txt"
		end
		loop do
			@rnd_word = words[Random.rand(words.length)]
			break if @rnd_word.length >= 5 && @rnd_word.length <= 12
		end
		@rnd_word.downcase!
		# puts "#{@rnd_word}"
		@rnd_word = @rnd_word.split("")
		@max_guesses = @rnd_word.length
	end

	def welcome_screen
		puts "Welcome to Hangman!"
		print "Load Game? (Y/N): "
		load_response = gets.chomp
		load_response.downcase!

		if load_response == "y"
			self.load_game
		else
			self.setup_displayed_word
			self.start_game
		end
	end

	def load_game
		if Dir.exists?("saves")
			Dir.foreach("saves") { |filename| puts "#{filename}" }

			print "Enter a @filename: "
			@filename = gets.chomp
			@filename.downcase!

			if File.exists?("saves/#{@filename}")
				lines = File.readlines("saves/#{@filename}")
				@displayed_word = lines[0]
				@guessed_letters = lines[1]
				@rnd_word = lines[2]
				@max_guesses = lines[3]
				@guesses_left = lines[4]

				@displayed_word = @displayed_word.split("")
				@rnd_word = @rnd_word.split("")
				# trim off newlines
				@guessed_letters = @guessed_letters[0..(@guessed_letters.size-2)]
				@max_guesses = @max_guesses[0..(@max_guesses.size-2)].to_i
				@guesses_left = @guesses_left[0..(@guesses_left.size-2)].to_i

				@playing_saved_game = true
				self.start_game
			else
				puts "#{@filename} does not exist!"
				self.load_game
			end
		else
			puts "There are no saves!"
			self.welcome_screen
		end
	end

	def save_game?
		print "Save Game? (Y/N): "
		wants_save = gets.chomp
		wants_save.downcase!

		if wants_save == "y"
			puts "Currently playing saved game: #{@filename}" if @playing_saved_game 
			print "filename: "
			save_name = gets.chomp
			save_name.downcase!
			Dir.mkdir("saves") unless Dir.exists?("saves")
			@filename = "saves/#{save_name}"
			if File.exists?(@filename)
				puts "Filename already exists, would you like to overwrite your save? (Y / N): "
				response = gets.chomp
				response.downcase!
				if response == "y"
					save_file = self.populate_save_template
					File.open(@filename, 'w') {|file| file.puts(save_file)}
				else
					puts "Aborting save."
				end
			else
				save_file = self.populate_save_template
				File.open(@filename, 'w') {|file| file.puts(save_file)}
			end
		end
	end

	def populate_save_template
		save_template = File.read("save_template.erb")
		erb_save_template = ERB.new(save_template)

		# change format of variables to strings
		# trim off "\n" at end to prevent newlines being inserted into the save_template.erb file
		@displayed_word = @displayed_word.join("")
		@displayed_word = @displayed_word[0..(@displayed_word.size-2)]
		@rnd_word = @rnd_word.join("")
		@rnd_word = @rnd_word[0..(@rnd_word.size-2)]

		save_file = erb_save_template.result(binding)

		# change back
		@displayed_word = @displayed_word.split("")
		@displayed_word << "\n"
		@rnd_word = @rnd_word.split("")
		@rnd_word << "\n"

		return save_file
	end

	def display_guess
		@displayed_word.each { |chr| print "#{chr} " }
	end

	def setup_displayed_word
		a = @rnd_word.size-1
		a.times { @displayed_word << "_" }
		@displayed_word << "\n"		# "\n" to match escape char at end of string in @rnd_word
	end

	def check_guess(guess)
		letter_found = false
		@rnd_word.each_with_index do |chr, idx|
			if chr == guess
				letter_found = true
				@displayed_word[idx] = chr
			end
		end
		return letter_found
	end

	def game_over?
		if @displayed_word.join("") == @rnd_word.join("")
			puts "You've won!!! :)"
			exit(1)
		end
	end

	def start_game
		puts "***[PLAY GAME]***"
		while @guesses_left > 0
			letter_found = false
			self.display_guess
			puts "Guesses Remaining: #{@guesses_left}"
			puts "Letters Guessed: #{@guessed_letters}"

			print "Guess a letter: "
			guess = gets.chomp
			guess.downcase!

			@guessed_letters += "#{guess}"

			letter_found = self.check_guess(guess)
			self.display_guess
			self.game_over?
			@guesses_left -= 1 if !letter_found   # only increase the @guesses_left if an incorrect letter was guessed

			self.save_game?
			2.times {print "\n"}
		end
		puts "Game Over :(" if @guesses_left == 7
	end

end

game = Hangman.new
