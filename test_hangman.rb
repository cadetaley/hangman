require "minitest/autorun"
require_relative "hangman.rb"

class Testhangmanfunctions < Minitest::Test 

	def test_class_returns_name
		hangman = Hangman.new("Austin")
		assert_equal(6,hangman.charcount)
	end
	def test_class_returns_name
		hangman = Hangman.new("Austin")
		assert_equal(["_","_","_","_","_","_"],hangman.blank)
	end
	def test_class_returns_if_password
		hangman = Hangman.new("Austin")
		letter = "A"
		assert_equal(true,hangman.correct_letter(letter))	
	end
	def test_class_user_guess_is_pushed_in_guessing_array
		hangman = Hangman.new("austin")
		hangman.guessed = ["b","l","c"]
		letter = "y"
		assert_equal(["b","l","c","y"])
	end
	def test_return_correct_index_position
		hangman = Hangman.new("austin")
		letter = "a"
		hangman.correct_index(letter)
		assert_equal(["a","_","_","_","_","_"],hangman.corect_blank)
	end
	def test_return_correct_index_position
		hangman = Hangman.new("austin")
		hangman.correct_index = ["a","_","_","_","_","_"]
		letter = "u"
		hangman.correct_index(letter)
		assert_equal(["a","u","_","_","_","_"],hangman.corect_blank)
	end
	
end