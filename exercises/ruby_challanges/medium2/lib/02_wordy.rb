class WordProblem
  attr_reader :operation

  def initialize(question)
    unless question =~ /What is /
      raise ArgumentError, "Invalid Question"
    else
      @operation = question.gsub(/(What is |\?)/, '')
    end
  end
  
    
  
end


p WordProblem.new('What is 3 divided by 3?').operation