class AvailableDate
  include DataMapper::Resource

  property :id, Serial
  property :available_date, Date
  property :space_id, String
  
end