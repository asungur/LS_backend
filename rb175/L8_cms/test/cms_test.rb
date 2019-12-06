ENV["RACK_ENV"] = "test"

require "minitest/autorun"
require "rack/test"

require_relative "../cms"

class AppTest < Minitest::Test
  include Rack::Test::Methods

  def app
    Sinatra::Application
  end

  def test_index
    get "/"
    assert_equal 200, last_response.status
    assert_equal "text/html;charset=utf-8", last_response["Content-Type"]
    assert_includes last_response.body, "about.txt"
    assert_includes last_response.body, "changes.txt"
    assert_includes last_response.body, "history.txt"
  end

  def test_viewing_text_document
    get "/history.txt"
    
    assert_equal 200, last_response.status
    assert_equal "text/plain", last_response["Content-Type"]
    assert_includes last_response.body, "Ruby 0.95 released"
    assert_includes last_response.body, "Ruby 1.0 released"
    assert_includes last_response.body, "2000 - Ruby 1.6 released"
    assert_includes last_response.body, "2013 - Ruby 2.0 released."
    assert_includes last_response.body, "Yukihiro Matsumoto"
  end

  def test_document_not_found
    get "/notafile.ext"
    
    assert_equal 302, last_response.status # Assert that the user was redirected
    
    get last_response["Location"] # Request the page that the user was redirected to
    
    assert_equal 200, last_response.status
    assert_includes last_response.body, "notafile.ext does not exist"
    
    get "/" # Reload the page
    refute_includes last_response.body, "notafile.ext does not exist" # Assert that our message has been removed
  end

  def test_index
    get "/"

    assert_equal 200, last_response.status
    assert_equal "text/html;charset=utf-8", last_response["Content-Type"]
    assert_includes last_response.body, "about.md"
    assert_includes last_response.body, "changes.txt"
    assert_includes last_response.body, "history.txt"
  end
end