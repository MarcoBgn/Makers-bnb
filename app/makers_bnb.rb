ENV['RACK_ENV'] ||= 'development'

require 'sinatra/base'
require 'sinatra/flash'
require_relative 'data_mapper_setup.rb'
require 'sinatra/flash'
require 'sinatra/partial'
require 'date'
require 'json'


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
    @user = User.new
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

  get '/sessions/new' do
    erb :'sessions/new'
  end

  post '/sessions' do
    user = User.authenticate(params[:email], params[:password])
    if user
      session[:user_id] = user.id
      redirect '/spaces'
    else
      flash.now[:errors] = ['The email or password is incorrect']
      erb :'sessions/new'
    end
  end

  delete '/sessions' do
    flash[:notice] = "See you later, #{current_user.name}"
    session[:user_id] = nil
    redirect '/'
  end

  get '/spaces' do
    if session[:space_array]
      @spaces = session[:space_array].map do |space_id|
        Space.get(space_id)
      end
    else
      @spaces = Space.all
    end
    erb :'spaces/index'
  end

  get '/requests/:space' do
    @space = Space.get(params[:space])
    available_dates = AvailableDate.all(space_id: params[:space])
    @formatted_dates = []
    available_dates.each do |date|
      @formatted_dates << date.available_date.strftime
    end
    erb :'requests/new'
  end

  post '/requests/new' do
    request = Request.create(user_id: current_user.id, space_id: params[:space_id])
    flash.keep[:notice] = 'Booking requested'
    redirect '/users/account'
  end

  post '/spaces' do
    date_from = Date.parse(params[:available_from])
    date_to = Date.parse(params[:available_to])
    available_dates = []
    (date_from..date_to).each do |date|
      AvailableDate.all(available_date: date).each do |x|
        available_dates << x
        end
      end
    if available_dates && !available_dates.empty?
      available_spaces = available_dates.map do |date|
        date.space_id
      end
      session[:space_array] = available_spaces.uniq
    else
      flash[:notice] = 'No spaces available for requested dates'
    end

    redirect to '/spaces'
  end


  post '/reset_search' do
    p "I am resetting the search"
    session[:space_array] = nil
    redirect to '/spaces'
  end

  get '/spaces/new' do
    if current_user
      erb :'spaces/new'
    else
      flash.keep[:errors] = ['Plese login to list a space']
      redirect '/sessions/new'
    end
  end

  post '/spaces/new' do
    @space = Space.create(name: params[:name], description: params[:description], price: params[:price], available_from: params[:available_from], available_to: params[:available_to], user_id: current_user.id)
    if @space.save
      date_from = @space.available_from
      date_to = @space.available_to
      (date_from..date_to).each do |date|
        AvailableDate.create(available_date: date, space_id: @space.id)
      end
      redirect to '/spaces'
    else
      flash[:notice] = 'Please complete the required fields'
      redirect to '/spaces/new'
    end
  end

  helpers do
    def current_user
      @current_user ||= User.get(session[:user_id])
    end
  end

  run! if app_file == $0
end
