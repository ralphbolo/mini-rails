# This file is used by Rack-based servers to start the application.

# require_relative 'config/environment'

# run Rails.application

class App
  def call(env)
    if env["REQUEST_METHOD"] == "GET" && env["PATH_INFO"] == "/hello"
      [
        200, # status code
        { 'Content-type' => 'text/plain' }, # response headers
        [ 'hello' ] # response body
      ]
    else
      [
        404, # status code
        { 'Content-type' => 'text/plain' }, # response headers
        [ 'not working' ] # response body
      ]
    end
  end  
end


# # equivalent to above code
# app = lambda do |env|
#   [
#     200, # status code
#     { 'Content-type' => 'text/plain' }, # response headers
#     [ 'hello lambda test' ] # response body
#   ]
# end
# run app

# Logger middleware
class Logger
  def initialize(app)
    @app = app
  end

  def call(env)
    method = env["REQUEST_METHOD"]
    path = env["PATH_INFO"]
    puts "#{method} #{path}"
    @app.call(env)
  end
end

# # run Logger.new(app)
use Logger

# use Rack::ShowExceptions
# use Rack::CommonLogger

# run app
run App.new
