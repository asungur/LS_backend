require "sinatra"
require "sinatra/reloader" if development?
require 'tilt/erubis'

before do
  @toc = File.readlines("data/toc.txt")
end

helpers do
  def in_paragraphs(chapter)
    chapter.split("\n\n").map.with_index do |line, index|
      "<p id=paragraph_#{index}>#{line}</p>"
    end.join
  end

  def emphasize(text, word)
    text.gsub(word, "<strong>#{word}</strong>")
  end
end

get "/" do
  @title = 'The Adventures of Sherlock Holmes'
  erb :home
end

get "/chapters/:number" do
  number = params[:number].to_i
  chapter_name = @toc[number - 1]

  redirect '/' unless (1..@toc.size).cover?(number)

  @title = "Chapter #{number}: #{chapter_name}"
  @chapter = File.read("data/chp#{number}.txt")

  erb :chapter
end

get "/search" do
  @results = chapters_matching(params[:query])
  erb :search
end

not_found do
  redirect '/'
end

def each_chapter
  @toc.each_with_index do |name, i|
    number = i + 1
    contents = File.read("data/chp#{number}.txt")
    yield number, name, contents
  end
end

def chapters_matching(query)
  results = []
  return results if !query || query.empty?

  each_chapter do |number, name, contents|
    matches = {}
    contents.split("\n\n").each_with_index do |paragraph, index|
      matches[index] = paragraph if paragraph.include? query
    end
    results << { number: number, name: name, paragraphs: matches } if matches.any?
  end

  results
end