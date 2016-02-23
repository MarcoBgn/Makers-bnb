ENV['RACK_ENV'] ||= 'development'

require 'sinatra/base'
require 'sinatra/flash'
require_relative 'data_mapper_setup.rb'

class MakersBnb < Sinatra::Base
  enable :sessions
  register Sinatra::Flash

  get '/' do
    'Hello MakersBnb!'
  end

  get '/spaces' do
    @spaces = Space.all
    erb :'spaces/index'
  end

  get '/spaces/new' do
    p "flash notice (after redirect) is #{flash[:notice]}"
    erb :'spaces/new'
  end

  post '/spaces/new' do
    @space = Space.create(name: params[:name], description: params[:description], price: params[:price], available_from: params[:available_from], available_to: params[:available_to])
    if @space.save
      redirect to '/spaces'
    else
      flash[:notice] = 'Please complete the required fields'
      redirect to '/spaces/new'
    end
  end


  run! if app_file == $0
end
