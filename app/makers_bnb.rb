ENV['RACK_ENV'] ||= 'development'

require 'sinatra/base'
require './app/data_mapper_setup.rb'

class MakersBnb < Sinatra::Base
  get '/' do
    redirect '/users/new'
  end
  
  get '/users/new' do
    erb :'users/new'
  end
  
  post '/users/new' do
    @user = User.new(email: params[:email],
                        password: params[:password],
                        password_confirmation: params[:password_confirmation], 
                        name: params[:name], 
                        username: params[:username])
    @user.save
  end

  
  run! if app_file == $0
end



