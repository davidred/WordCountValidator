require 'sinatra'
require "sinatra/reloader" if development?

get '/' do
  files = %w(texts/0 texts/1 texts/2 texts/3 texts/4 texts/5)

  text_file = files.sample
  source_text = File.read(text_file).strip

  exclude = create_exclude_list(source_text)

  # for i in ((text_array.length-5)...(text_array.length))
  #   exclude << text_array[i]
  # end

  erb :"get.json", locals: { source_text: source_text, exclude: exclude }
end

def get_uniqs(text)
  uniqs = text.split.map { |word| word.gsub(/[^a-zA-Z\s\']/,"")}.uniq
end

def create_exclude_list(text)
  exclude = []
  uniqs = get_uniqs(text)
  uniq_length = uniqs.length - 1
  num_words = (uniq_length == 0) ? 0 : rand([uniq_length, 5].min) + 1

  until exclude.length == num_words
    word = uniqs.sample
    exclude << word unless exclude.include?(word) #this would run faster if the word is deleted
  end

  exclude
end
##Assumptions

#The exclude array should contain words randomly selected from the text

#There should be a maximum of 5 exclusion words

#There should be less exclusion words than unique words in the text

#Exclusion words should be unique and case-sensitive

#Exclusion ignores punctuation
