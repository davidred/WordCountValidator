# Word Count Validator

## Objective

Recently the internet has exploded to reach across the galaxy.  There is a hostile species of troll aliens that have started infesting the internet with disruptive, angry comments on internet forums.  Scientists have determined that the troll aliens are really bad at counting words.  Thus they have tasked you with creating a type of [CAPTCHA](http://en.wikipedia.org/wiki/CAPTCHA) for troll aliens to keep them out of the forums. Trying to be helpful, the scientists have sent along some starter code. It's not complete and some things could probably be done better. To run the CAPTCHA follow these instructions:

        # You can get everything installed using
        bundle install

        # Run the server using
        ./run

        # Run the test suite via
        rspec

## Assumptions

Fighting troll aliens in a timely fashion led the team to make the following assumptions:


-The array of words to be excluded should be randomly selected from the text

-The number of excluded words should be random. There should be at most 5, but less than the number of unique words in the text

-The words to be excluded should be unique

-The words to be excluded should be case-sensitive (Everyone knows troll aliens are terrible at uppercase)

-The words to be excluded should ignore punctuation

-The response text must be checked against our available texts to make sure it came from our server!
