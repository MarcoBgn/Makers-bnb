ENV['RACK_ENV'] ||= 'development'

require 'sinatra/base'
require_relative 'data_mapper_setup.rb'
require 'sinatra/flash'
require 'sinatra/partial'



class MakersBnb < Sinatra::Base

  register Sinatra::Flash
  register Sinatra::Partial

  enable :partial_underscores
  enable :sessions

  set :partial_template_engine, :erb
  set method_override: true

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
    if @user.save
      session[:user_id] = @user.id
      redirect '/users/account'
    else
      flash.now[:errors] = @user.errors.full_messages
      erb :'users/new'
    end
  end

  get '/users/account' do
    erb :'users/account'
  end
  
  delete '/sessions' do
    flash[:notice] = "See you later, #{current_user.name}"
    session[:user_id] = nil
    redirect '/'
  end

  get '/spaces' do
    @spaces = Space.all
    erb :'spaces/index'
  end

  get '/spaces/new' do
    erb :'spaces/new'
  end

  post '/spaces/new' do
    Space.create(name: params[:name], description: params[:description], price: params[:price])
    redirect to '/spaces'
  end

  helpers do
    def current_user
      @current_user ||= User.get(session[:user_id])
    end
  end

  run! if app_file == $0
end
