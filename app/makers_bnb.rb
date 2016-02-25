ENV['RACK_ENV'] ||= 'development'

require 'sinatra/base'
require 'sinatra/flash'
require_relative 'data_mapper_setup.rb'
require 'sinatra/flash'
require 'sinatra/partial'
require 'date'
require 'json'

require_relative 'helpers'

class MakersBnb < Sinatra::Base

  register Sinatra::Flash
  register Sinatra::Partial

  enable :partial_underscores
  enable :sessions

  set :partial_template_engine, :erb
  set method_override: true

  helpers Helpers

  get '/' do
    redirect '/users/new'
  end

  get '/edit/:space_id' do
    unless current_user
      redirect '/sessions/new'
    end
    @space = Space.get(params[:space_id])
    if current_user.id == @space.user_id
      erb :'spaces/edit'
    else
      redirect '/users/account'
    end
  end

  post '/edit'do
  Space.get(params[:space_id]).update(name: params[:name], description: params[:description], price: params[:price])
  redirect to 'users/account'
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
      flash[:notice] = "Welcome, #{@user.name}"
      redirect '/spaces'
    else
      flash.now[:errors] = @user.errors.full_messages
      erb :'users/new'
    end
  end

  get '/users/account' do
    if current_user
      @users_spaces = Space.all(user_id: current_user.id)
      erb :'users/account'
    else
      redirect '/sessions/new'
    end
  end

  get '/sessions/new' do
    erb :'sessions/new'
  end

  post '/sessions' do
    @user = User.authenticate(params[:email], params[:password])
    if @user
      session[:user_id] = @user.id
      flash[:notice] = flash[:notice] = "Welcome, #{@user.name}"
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
    session[:space_array] = nil
    erb :'spaces/index'
  end

  get '/requests/:space' do
    @space = Space.get(params[:space])
    available_dates = AvailableDate.all(space_id: params[:space])
    @formatted_dates = []
    available_dates.each do |date|
      @formatted_dates << date.available_date.strftime
    end
    session[:array] = @formatted_dates.to_json
    erb :'requests/new'
  end

  post '/requests/new' do
    date = Date.parse(params[:date_requested])
    space = Space.get(params[:space_id])
    request = Request.create(user_id: current_user.id, space_id: params[:space_id], date_requested: date, owner_id: space.user_id, space_name: space.name)
    flash.keep[:notice] = 'Booking requested'
    redirect '/users/account'
  end

  get '/requests' do
    if current_user
      @users_requests = Request.all(user_id: current_user.id)
      @received_requests = Request.all(owner_id: current_user.id)
      @request_display = @users_requests.map do |x|
        Space.get(x.space_id)
      end
      erb :'requests/index'
    else
      redirect to '/sessions/new'
    end
  end

  post '/spaces' do
    validate_dates(params[:available_from], params[:available_to], '/spaces')
    find_available_spaces(params[:available_from], params[:available_to])
    redirect to '/spaces'
  end

  get '/spaces/new' do
    if current_user
      @todays_date = Date.today
      erb :'spaces/new'
    else
      flash.keep[:errors] = ['Plese login to list a space']
      redirect '/sessions/new'
    end
  end

  post '/spaces/new' do

    validate_dates(params[:available_from],params[:available_to], 'spaces/new')
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

  run! if app_file == $0
end
