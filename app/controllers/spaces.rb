class MakersBnb < Sinatra::Base

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

end
