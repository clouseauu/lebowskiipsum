# Load the rails application
require File.expand_path('../application', __FILE__)

# Initialize the rails application
Lebowski::Application.initialize!

DEFAULT_OPTIONS = {
  paragraphs: 5,
  cussin: true,
  mixed: true,
  startleb: true,
  html: false,
  characters: 'all'
}

LEBOWSKI_OPTIONS = {
  min_words: 65, # Words per paragraph
  max_words: 120,
  min_sentence: 4, # Words per sentence
  max_sentence: 14
}