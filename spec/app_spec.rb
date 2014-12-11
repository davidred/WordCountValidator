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

    it "is case sensitive" do
      expect(get_uniqs("Hey hey")).to eq(["Hey", "hey"])
    end

    it "returns an empty array if there is only one unique word" do
      expect(create_exclude_list("Yo")).to eq([])
    end

  end

  context "When validating a set of words it" do

    it "returns true if the text is included in one of the files" do
      expect(possible_text?("The quick brown fox jumped over the lazy dog.")).to eq(true)
    end

    it "returns false if the text is not included in one of the files" do
      expect(possible_text?("lkaj dfASFDL KJVca slkvi")).to eq(false)
    end

    it "returns correct answer" do
      expect(word_count("How now brown cow", ["now", "cow"])).to eq({'How' => 1, 'brown' => 1})
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

  end

  context "When receiving a response from the client it" do
    it "returns 200 if the response is correct" , :type => :request do
      post '/', :response => {
        :text => "The quick brown",
        :exclude => ['quick'],
        :answer => {'The' => 1, 'brown' => 1}
      }
      expect(last_response).to be_ok
    end

    it "prevents cheating and returns 400 when response text is not one of the possible texts", :type => :request do
      post '/', :response => {:text => "How now brown cow", :exclude => ['now', 'cow'], :answer => {:How => 2, :brown => 1}}
      expect(last_response).not_to be_ok
    end

    it "returns 400 when answer excludes the right words, but does not count remaining words correctly" do
      post '/', :response => {
        :text => "The quick brown",
        :exclude => ['quick'],
        :answer => {'The' => 2, 'brown' => 1}
      }
    end

    it "returns 400 when answer counts the words correctly, but does not exclude all the words" do
      post '/', :response => {
        :text => "The quick brown",
        :exclude => ['quick'],
        :answer => {'The' => 1, 'quick' => 1, 'brown' => 1}
      }
    end

    it "returns 400 when answer is not case-sensitive" do
      post '/', :response => {
        :text => "The quick brown",
        :exclude => ['quick'],
        :answer => {'the' => 1, 'brown' => 1}
      }
    end

  end


end
