ENV['RACK_ENV'] ||= 'development'

require 'sinatra/base'
require 'sinatra/flash'
require_relative 'data_mapper_setup.rb'
require 'sinatra/flash'
require 'sinatra/partial'
require 'date'
require 'json'

require_relative 'helpers'

require_relative 'server'
require_relative 'controllers/login'
require_relative 'controllers/users'
require_relative 'controllers/requests'
require_relative 'controllers/spaces'
