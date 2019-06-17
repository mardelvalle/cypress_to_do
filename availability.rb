require 'sinatra'
require 'yaml/store'
Choices = {
  'MON' => 'Monday',
  'TUE' => 'Tuesday',
  'WED' => 'Wednesday',
  'THU' => 'Thursday',
  'Fri' => 'Friday',
  'Sat' => 'Saturday',
  'Sun' => 'Sunday'
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

post '/to_do' do
  @title = 'What will you do today?'
  @choice = params['choice']
  @store = YAML::Store.new 'response.yml'
  @store.transaction do
    @store['response'] ||= {}
    @store['response'][@choice] ||= 0
    @store['response'][@choice] += 1
  end
  erb :to_do
end

get '/results' do
  @title = 'Results so far:'
  @store = YAML::Store.new 'response.yml'
  @response = @store.transaction { @store['choice'] }
  erb :results
end
