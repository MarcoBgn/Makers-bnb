class Space
  include DataMapper::Resource
  
  property :id, Serial
  property :name, String, required: true
  property :description, Text
  property :price, String, required: true
  
end
