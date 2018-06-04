# This file is used by Rack-based servers to start the application.

require_relative 'config/environment'

run Rails.application

# class App
#   def call(env)
#     if env["REQUEST_METHOD"] == "GET" && env["PATH_INFO"] == "/hello"
#       [
#         200, # status code
#         { 'Content-type' => 'text/plain' }, # response headers
#         [ 'hello' ] # response body
#       ]
#     else
#       [
#         404, # status code
#         { 'Content-type' => 'text/plain' }, # response headers
#         [ 'not working' ] # response body
#       ]
#     end
#   end  
# end

# Sinatra implementation
# class MiniSinatra 
#   class Route < Struct.new(:method, :path, :block)
#     def match?(env)
#       env["REQUEST_METHOD"] == method && env["PATH_INFO"] == path
#     end
#   end

#   def initialize
#     @routes = []
#   end

#   def add_route(method, path, &block)
#     @routes << Route.new(method, path, block)
#   end

#   def call(env)
#     if route = @routes.detect { |route| route.match?(env) }
#       body = route.block.call
#       [
#         200, # status code
#         { 'Content-type' => 'text/plain' }, # response headers
#         [ body ] # response body
#       ]
#     else
#       [
#         404, # status code
#         { 'Content-type' => 'text/plain' }, # response headers
#         [ 'not found' ] # response body
#       ]
#     end
#   end 
  
#   def self.application
#     @application ||= MiniSinatra.new
#   end
# end

# def get(path, &block)
#   MiniSinatra.application.add_route "GET", path, &block
# end

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
# class Logger
#   def initialize(app)
#     @app = app
#   end

#   def call(env)
#     method = env["REQUEST_METHOD"]
#     path = env["PATH_INFO"]
#     puts "#{method} #{path}"
#     @app.call(env)
#   end
# end

# run Logger.new(app)
# use Logger

# use Rack::ShowExceptions
# use Rack::CommonLogger

# run app
# run App.new


# app = MiniSinatra.new

# get "/hello" do
#   "hello"
# end

# get "/bye" do
#   "bye"
# end

# run MiniSinatra.application
