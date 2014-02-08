class PlaceFinder < Sinatra::Base
  get '/register' do
    erb :register
  end

  post '/register' do
    begin
      User.register_user params[:username],
                         params[:password],
                         params[:repeat_password],
                         params[:name]
    rescue RegisterException => e
      @message = e.message
      erb :register_failure
    else
      erb :register_successful
    end
  end
end