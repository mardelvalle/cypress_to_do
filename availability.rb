require 'sinatra'
require 'yaml/store'
Transaction = {
  'S' => 'Spent',
  'P' => 'Payed',
  'I' => 'Invested'
}
get '' do
  @title = 'What day is it?'
    erb :index
end

get '*' do
  @title = 'Welcome'
    erb :index
end

get '/' do
  @title = 'Welcome to the Survey'
    erb :index
end

post '/reflect' do
  @title = 'What will you do today?'
  @choice = params['choice']
  @money = params['money'].to_f
   @store = YAML::Store.new 'response.yml'
  @store.transaction do
    @store['response'] ||= {}
    @store['response'][@choice] ||= 0
    @store['response'][@choice] += @money
  end
  erb :reflect
end

get '/results' do
  @title = 'Results so far:'
  @choose = params['choice']
  @store = YAML::Store.new 'response.yml'
  @response = @store.transaction { @store['choice'] }

  erb :results
end
