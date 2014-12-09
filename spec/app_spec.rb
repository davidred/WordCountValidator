require "./spec/spec_helper"
require "json"

describe 'The Word Counting App' do
  def app
    Sinatra::Application
  end

  

  context "When receiving a get request it" do

    it "returns 200 and has the right keys" do
      get '/'
      expect(last_response).to be_ok
      parsed_response = JSON.parse(last_response.body)
      expect(parsed_response).to have_key("text")
      expect(parsed_response).to have_key("exclude")
    end

    it "returns a response that includes text"

    it "returns a response that includes a list of excluded words"

    it "returns an empty list if the text has only one unique word"
  end

  context "When receiving a post request it" do

  end


end
