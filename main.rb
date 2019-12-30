require_relative 'framework'
require_relative 'db'
require_relative 'queries'

DB = Databse.connect('postgres://localhost/framework_dev',QUERIES)

APP = App.new do

  get '/' do
    "This is root"
  end

  get '/users/:username' do |params|
    "This is a #{params.fetch('username')}"
  end
  get '/submissions' do |params|
    # DB.exec_sql('select * from submissions;')
    DB.all_submissions


  end

  get '/submissions/:name' do |params|
    name = params.fetch('name')
    #  DB.exec_sql('select * from submissions where name =')
    user = DB.find_submissions_by_name(name,params).fetch(0)
    "The user is #{user.fetch('name')}"

  end
end
