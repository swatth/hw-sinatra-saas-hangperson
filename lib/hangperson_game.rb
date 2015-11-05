class HangpersonGame

  # add the necessary class methods, attributes, etc. here
  # to make the tests in spec/hangperson_game_spec.rb pass.

  attr_accessor :word
  attr_accessor :guesses
  attr_accessor :wrong_guesses

  # Get a word from remote "random word" service

  def initialize()
    @word = get_random_word
    @guesses = ''
    @wrong_guesses = ''
  end
  
#  def initialize(word)
#    @word = word
#    @guesses = ''
#    @wrong_guesses = ''
#  end

  def self.get_random_word
    require 'uri'
    require 'net/http'
    uri = URI('http://watchout4snakes.com/wo4snakes/Random/RandomWord')
    Net::HTTP.post_form(uri ,{}).body
  end

  def guess(alphabet)
    
    raise ArgumentError if alphabet == nil
    raise ArgumentError if alphabet.length != 1

    alphabet.downcase!

    raise ArgumentError if !('abcdefghijklmnopqrstuvwxyz'.include? alphabet)
    
    if @word.include? alphabet
      if @guesses.include? alphabet
        return false 
      else
        @guesses << alphabet
        return true
      end
      #puts @guesses
    else
      if @wrong_guesses.include? alphabet
        return false
      else
        @wrong_guesses << alphabet
        return true
      end
      #puts @wrong_guesses
    end
  end

  def word_with_guesses()
    word_to_show = ''
    @word.each_char do |i|
      if guesses.include? i
        word_to_show << i
      else
        word_to_show << '-'
      end
    end
    return word_to_show
  end

  def check_win_or_lose()
    if self.word_with_guesses() == @word
      return :win
    elsif @wrong_guesses.length >= 7
      return :lose
    else
      return :play
    end  
  end
 
end

game = HangpersonGame.new()

puts games.word

