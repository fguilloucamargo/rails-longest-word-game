require 'open-uri'
require 'json'

class GamesController < ApplicationController

  def new
    alphabet = ('a'..'z').to_a
    @letters = []
    10.times { @letters << alphabet[rand(0..25)] }
    @letters
  end

  def score
    @word = params[:word]
    url = "https://wagon-dictionary.herokuapp.com/#{@word}"
    word_check = JSON.parse(open(url).read)
    grid = params[:letters]
    time = (end_time - start_time)
    return @message = "#{@word.capitalize} can\'t be built out with the letters" unless word_in_letters(grid, @word)

    @message = word_check["found"] ? "Great" : "#{@word.capitalize} is not a English word"
  end

  def word_in_letters(letters, word)
    grid = letters.split(" ")
    all_in_grid = true
    word.split("").each do |letter|
      all_in_grid = false unless letters.include?(letter)
      grid.delete_at(grid.index(letter)) unless letters.index(letter).nil?
    end
    all_in_grid
  end
end
