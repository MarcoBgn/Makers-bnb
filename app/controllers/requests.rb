class MakersBnb < Sinatra::Base

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

  post '/requests/new' do

    requested_date = Date.parse(params[:date_requested]) rescue nil

    unless requested_date
      flash[:notice] = 'Please enter a valid date'
      redirect '/spaces'
    end

    unless session[:available_dates].include?(Date.parse(params[:date_requested]).strftime)
      flash[:notice] = 'Space not available on the requested date'
      redirect '/spaces'
    end

    if current_user
      unless current_user.id != Space.get(params[:space_id]).user_id
        flash[:notice] = 'This is your own space'
        redirect '/spaces'
      end
      date = Date.parse(params[:date_requested])
      space = Space.get(params[:space_id])
      request = Request.create(user_id: current_user.id, space_id: params[:space_id], date_requested: date, owner_id: space.user_id)
      flash.keep[:notice] = 'Booking requested'
      redirect '/users/account'
    else
      flash[:notice] = 'Please log in to request a space'
      redirect '/spaces'
    end
  end
  get '/requests/book/:space' do
    @space = Space.get(params[:space])
    available_dates = AvailableDate.all(space_id: params[:space])
    @formatted_dates = []
    available_dates.each do |date|
      @formatted_dates << date.available_date.strftime
    end
    session[:available_dates] = @formatted_dates
    session[:array] = @formatted_dates.to_json
    erb :'requests/new'
  end

  get '/requests/confirm/:request_id' do
    @request_received = Request.get(params[:request_id])
    @requests_count = Request.all(space_id: @request_received.space_id).count
     erb :'/requests/confirm'
  end

  post '/requests/confirm' do
    @confirm_request = Request.get(params[:confirm_request])
    @confirm_request.update(:status => :confirmed)
    @requests_for_same_space = Request.all(space_id: params[:space_requested])
    @requests_for_same_space.each do |request|
      unless request.status == "confirmed"
        request.update(:status => :denied)
      end
    end
    date = Date.parse(params[:date_requested])
    @available_dates_array = AvailableDate.all(space_id: params[:space_requested])
    @available_dates_array.each do |aval_date|
      if aval_date.available_date == date
        aval_date.destroy
      end
    end

    redirect '/requests'
  end

  post '/requests/deny' do
    @deny_request = Request.get(params[:deny_request])
    @deny_request.update(:status => :denied)
    redirect '/requests'
  end

end
