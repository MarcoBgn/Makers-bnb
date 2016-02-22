require 'sinatra/base'

class MakersBnb < Sinatra::Base
  get '/' do
    'Hello MakersBnb!'
  end

  
  run! if app_file == $0
end
