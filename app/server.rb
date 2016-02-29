class MakersBnb < Sinatra::Base

  enable :sessions
  register Sinatra::Flash
  register Sinatra::Partial
  set :partial_template_engine, :erb
  helpers Helpers

  enable :partial_underscores
  set method_override: true

end
