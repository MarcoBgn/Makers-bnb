require 'data_mapper'
require_relative 'models/space.rb'
require_relative 'models/available_date'

DataMapper.setup(:default, ENV['DATABASE_URL'] || "postgres://localhost/makers_bnb_#{ENV['RACK_ENV']}")
DataMapper::Logger.new($stdout, :debug)
DataMapper.finalize
DataMapper.auto_upgrade!
