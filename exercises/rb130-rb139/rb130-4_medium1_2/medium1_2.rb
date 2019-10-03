class TextAnalyzer
  def process
    text = File.open("text_file.txt").read
    yield(text) if block_given?
    file.close
  end
end

analyzer = TextAnalyzer.new

analyzer.process { |txt| puts "#{txt.split("\n\n").size} paragraphs" }
analyzer.process { |txt| puts "#{txt.lines.count} lines" }
analyzer.process { |txt| puts "#{txt.split(' ').size} words" }


# LS SOLUTION

# class TextAnalyzer
#   def process
#     file = File.open('sample_text.txt', 'r')
#     yield(file.read)
#     file.close
#   end
# end

# analyzer = TextAnalyzer.new
# analyzer.process { |text| puts "#{text.split("\n\n").count} paragraphs" }
# analyzer.process { |text| puts "#{text.split("\n").count} lines" }
# analyzer.process { |text| puts "#{text.split(' ').count} words" }