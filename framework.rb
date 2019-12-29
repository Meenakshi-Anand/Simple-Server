class App

  def initialize(&block)
    @routes = RouteTable.new(block)
  end

  def call(env)
    request = Rack::Request.new(env)
    # look for methods
    # p(request.methods - Object.new.methods).sort
    @routes.each do |route|
     content = route.match(request)
     return [200,{},[content]] if content
    end
    [404,{},["Page not found"]]
  end

  class RouteTable

    def initialize(block)
      @routes = []
      instance_eval(&block)
    end

    def get(route_spec,&block)
      @routes << Route.new(route_spec,block)
    end

    def each(&block)
      @routes.each(&block)
    end

  end

  class Route < Struct.new(:route_spec,:block)

    def match(request)
      if request.path == route_spec
        block.call
      else
        nil
      end
    end

  end

end