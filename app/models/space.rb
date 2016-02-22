class Space
  include DataMapper::Resource
  property :id, Serial
  property :name, String
  property :description, Text
  property :price, String
  property :available_from, Date
  property :available_to, Date

end
