require "socket"

def parse_request(line)
  http_method, path_and_params, http = line.split(" ")
  path, my_params = path_and_params.split("?")
  
  my_params = (my_params || "").split("&").each_with_object({}) do |pair, hash|
    key, value = pair.split("=")
    hash[key] = value
  end
  [http_method, path, my_params]
end


server = TCPServer.new(ENV["IP"], ENV["PORT"])
loop do
  client = server.accept
  
  request_line = client.gets
  next if !request_line || request_line =~ /favicon/
  
  http_method, path, my_params = parse_request(request_line)
  
  client.puts "HTTP/1.1 200 OK"
  client.puts "Content-Type: text/html"
  client.puts

  client.puts "<pre>"
  client.puts request_line
  client.puts http_method
  client.puts path
  client.puts my_params
  client.puts "</pre>"

  client.puts "<h1>Counter</h1>"
  
  number = my_params["number"].to_i
  client.puts "<p>The current number is #{number}.</p>"

  client.puts "<a href='?number=#{number + 1}'>Add one</a>"
  client.puts "<a href='?number=#{number - 1}'>Subtract one</a>"
  client.puts "</body>"
  client.puts "</html>"
  
  client.close
end