module ActionDispatch
  module Routing
    class RouteSet
      class Route < Struct.new(:method, :path, :controller, :action, :name)
        def match?(request)
          request.request_method == method && request.path_info == path
        end

        def controller_class
          "#{controller.classify}Controller".constantize
        end
  
        def dispatch(request)
          controller = PostsController.new
          controller.request = request
          controller.response = Rack::Response.new
          controller.process(action)
          controller.response
        end
      end

      def initialize
        @routes = []
      end

      def add_route(*args)
        route = Route.new(*args)
        @routes << route
        route
      end

      def find_route(request)
        @routes.detect { |route| route.match?(request) }
      end

      def draw(&block)
        mapper = Mapper.new(self)
        mapper.instance_eval(&block)
      end

      def call(env)
        request = Rack::Request.new(env)

        if route = find_route(request)
          route.dispatch(request)
        else
          [404, {'Content-Type' => 'text/plain'}, ['Not found']]
        end
      end

      def url_helpers
        routes = @routes 

        Module.new do
          routes.each do |route|
            if route.name 
              
              # define_method explanation
              
              # define_method(:my_method) do |foo, bar| # or even |*args|
              #   # do something
              # end
          
              # def my_method(foo, bar)
              #   # do something
              # end
              define_method(route.name + "_path") do | params = nil |
                if params
                  route.path + "?" + Rack::Utils.build_query(params)
                else
                  route.path
                end
              end
            end
          end  
        end
      end
    end
  end
end