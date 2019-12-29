require_relative 'framework'

APP = App.new do

  get '/' do
    "This is root"
  end

  get '/users/:username' do |params|
    "This is a #{params.fetch('username')}"
  end

end
