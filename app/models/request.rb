class Request
  include DataMapper::Resource
  
  property :id, Serial
  property :date_requested, Date
  property :owner_id, Integer
  property :space_name, String
  property :status, String, :default => :pending
  
  

  belongs_to :user
  belongs_to :space

end
