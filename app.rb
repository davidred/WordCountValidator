require 'sinatra'
require "sinatra/reloader" if development?

get '/' do
  files = %w(texts/0 texts/1 texts/2 texts/3 texts/4 texts/5)

  text_file = files.sample
  source_text = File.read(text_file).strip
  text_array = source_text.split

  exclude = []
  for i in ((text_array.length-5)...(text_array.length))
    exclude << text_array[i]
  end

  erb :"get.json", locals: { source_text: source_text, exclude: exclude }
end


##Assumptions

#The exclude array should contain words randomly selected from the text

#There should be a maximum of 5 exclusion words

#There should be less exclusion words than unique words in the text

#Exclusion words should be unique and case-sensitive
