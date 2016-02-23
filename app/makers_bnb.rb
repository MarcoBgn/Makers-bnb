ENV['RACK_ENV'] ||= 'development'

require 'sinatra/base'
require 'sinatra/flash'
require_relative 'data_mapper_setup.rb'
require 'date'

class MakersBnb < Sinatra::Base
  enable :sessions
  register Sinatra::Flash

  get '/' do
    'Hello MakersBnb!'
  end

  post '/spaces' do
    date_from = Date.parse(params[:available_from])
    date_to = Date.parse(params[:available_to])
    available_dates = (date_from..date_to).map do |date|
      AvailableDate.all(available_date: date)
    end
    if available_dates && !available_dates.empty?
      available_spaces = available_dates.map do |date|
        date.first.space_id
      end
      session[:space_array] = available_spaces.uniq
    end
    redirect to '/spaces'
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

  post '/reset_search' do
    session[:space_array] = nil
    redirect to '/spaces'
  end

  get '/spaces/new' do
    erb :'spaces/new'
  end

  post '/spaces/new' do
    @space = Space.create(name: params[:name], description: params[:description], price: params[:price], available_from: params[:available_from], available_to: params[:available_to])
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
