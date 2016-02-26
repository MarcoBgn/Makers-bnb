class Request
  include DataMapper::Resource
  
  property :id, Serial
  property :date_requested, Date
  property :owner_id, Integer
  property :status, String, :default => "not confirmed"

  belongs_to :user
  belongs_to :space

end
