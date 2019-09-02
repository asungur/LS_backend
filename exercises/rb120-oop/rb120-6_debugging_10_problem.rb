# We discovered Gary Bernhardt's repository for finding out whether something rocks or not, and decided to adapt it for a simple example.


class AuthenticationError < StandardError; end

# A mock search engine
# that returns a random number instead of an actual count.
class SearchEngine
  def self.count(query, api_key)
    unless valid?(api_key)
      raise AuthenticationError, 'API key is not valid.'
    end

    rand(200_000)
  end

  private

  def self.valid?(key)
    key == 'LS1A'
  end
end

module DoesItRock
  API_KEY = 'LS1A'

  class NoScore; end

  class Score
    def self.for_term(term)
      positive = SearchEngine.count(%{"#{term} rocks"}, API_KEY).to_f
      negative = SearchEngine.count(%{"#{term} is not fun"}, API_KEY).to_f

      positive / (positive + negative)
    rescue ZeroDvisionError
      NoScore.new
    end
  end

  def self.find_out(term)
    score = Score.for_term(term)

    case score
    when NoScore
      "No idea about #{term}..."
    when 0...0.5
      "#{term} is not fun."
    when 0.5
      "#{term} seems to be ok..."
    else
      "#{term} rocks!"
    end
  rescue StandardError => e
    e.message
  end
end

# Example (your output may differ)

puts DoesItRock.find_out('Sushi')       # Sushi seems to be ok...
puts DoesItRock.find_out('Rain')        # Rain is not fun.
puts DoesItRock.find_out('Bug hunting') # Bug hunting rocks!


=begin
The SearchEngine indeed raises an AuthenticationError, but it never reaches the DoesItRock::find_out method, because Score::for_term already catches it, resulting in the return value NoScore.

But if the return value is NoScore, why does the find_out method not print the message "No idea about #{term}..."? In order to see this, recall how case statements work. The value of score will be compared with each value in the when clauses using the === operator. In case of the first when clause, the comparison is NoScore === score, and since the left-hand side is a class, its implementation boils down to checking whether score is_a? NoScore. This yields false when score has the value NoScore, as it is not an instance of the NoScore class. As a result, we end up with the value of the else clause.

In order to fix this, Score::for_term has to return an instance of the NoScore class (i.e. NoScore.new), instead of the name of the class itself.

Now, back to the original problem: if the API key is wrong, we want the AuthenticationError to reach the find_out method. One way to achieve this is to simply remove the rescue clause in Score::for_term. But this would also prevent us from rescuing other exceptions, like a possible ZeroDivisionError, which arguably is a perfect occasion to return no score. In order to solve this, we decide to rescue only that specific exception within Score::for_term and let all others through.

With those changes, the code runs as expected. However, there is still one thing wrong about our code, which is less obvious. And that's the use of Exception.

Exception is the top-most class in Ruby's exception hierarchy and it seems a straightforward choice to rescue or inherit from. But it's too broad. When creating custom exceptions and when rescuing exceptions, it's good practice to always use the subclass StandardError. StandardError subsumes all application-level errors. The other descendants of Exception are used for system- or environment-level errors, like memory overflows or program interruptions. These are the kind of errors your application usually does not want to throw - and definitely does not want to rescue, they should be handled by Ruby itself.

Further exploration
You may wish to review this blog article for a refresher on working with Ruby exceptions and the important difference between Exception and StandardError.

Finally, we shouldn't include sensitive information like API keys as plain text in our source code. The safest way to store them is using an environment variable (or a gem that simulates this). Don't worry about that now, though; just be aware of it.
=end