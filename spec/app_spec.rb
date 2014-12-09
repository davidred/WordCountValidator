require "./spec/spec_helper"
require "json"

describe 'The Word Counting App' do
  def app
    Sinatra::Application
  end

  context "When generating list of exlusion words it" do

    it "generates a list of unique words" do
      expect(get_uniqs("hey hey there there there there")).to eq([
        'hey',
        'there',
       ])
    end

    it "ignores punctuation" do
      expect(get_uniqs("Hey! Hey!!! You, You%$#$! I'm David")).to eq([
        'Hey',
        'You',
        "I'm",
        "David"
      ])
    end

    it "returns an empty array if there is only one unique word" do
      expect(create_exclude_list("Yo")).to eq([])
    end


  end



  context "When receiving a get request it" do

    it "returns 200 and has the right keys" do
      get '/'
      expect(last_response).to be_ok
      parsed_response = JSON.parse(last_response.body)
      expect(parsed_response).to have_key("text")
      expect(parsed_response).to have_key("exclude")
    end

    it "returns a response that includes text" do
      get '/'
      parsed_response = JSON.parse(last_response.body)
      expect(parsed_response['text']).to match(/\w+/)
    end

    it "returns a response that includes a list of excluded words" do
      get '/'
      parsed_response = JSON.parse(last_response.body)
      expect(parsed_response['exclude']).to be_a(Array)
    end

    it "returns an empty list if the text has only one unique word"
  end

  context "When receiving a post request it" do

  end


end
