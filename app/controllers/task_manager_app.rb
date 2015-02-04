class TaskManagerApp < Sinatra::Base
  set :root, File.join(File.dirname(__FILE__), '..')

  get '/' do
    erb :dashboard
  end

  get '/tasks' do
    @tasks = ["task1", "task2", "task3"]
    erb :index
  end
end
