class Request
  include DataMapper::Resource

  property :id, Serial
  property :date_requested, Date

  belongs_to :user
  belongs_to :space

end
