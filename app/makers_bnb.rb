ENV['RACK_ENV'] ||= 'development'

require 'sinatra/base'

class MakersBnb < Sinatra::Base
  get '/' do
    'Hello MakersBnb!'
  end

  get '/spaces' do
    erb :'spaces/index'
  end

  get '/spaces/new' do
    erb :'spaces/new'
  end


  run! if app_file == $0
end
