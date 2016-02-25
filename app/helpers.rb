module Helpers
  def current_user
    @current_user ||= User.get(session[:user_id])
  end
  
  def display_dates(requests_array, space)
    requests_array.first(space_id: space.id).date_requested.strftime
  end

  def validate_dates(params_from, params_to, route)
    date_from = Date.parse(params_from) rescue nil
    unless date_from
      flash[:notice] = 'Please complete the required fields'
      redirect to route
    end
    date_to = Date.parse(params_to) rescue nil
    unless date_to
      flash[:notice] = 'Please complete the required fields'
      redirect to route
    end
    if Date.parse(params_from) < Date.today || Date.parse(params_to) < Date.today
      flash[:notice] = 'do not enter a date before today'
      redirect to route
    elsif Date.parse(params_from) > Date.parse(params_to)
      flash[:notice] = 'do not enter a start date that is after the finish date'
      redirect to route
    elsif Date.parse(params_from) > Date.today.next_year || Date.parse(params_to) > Date.today.next_year
      flash[:notice] = 'do not enter dates that are more than a year from today'
      redirect to route
    end
  end

  def find_available_spaces(params_from, params_to)
    date_from = Date.parse(params_from)
    date_to = Date.parse(params_to)
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
  end
end