require_relative 'framework'

APP = App.new do

  get '/' do
    "This is root"
  end

  get '/users/:username' do
    'This is a user'
  end

end
