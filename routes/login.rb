class PlaceFinder < Sinatra::Base
  get '/logout' do
    User.logout
    redirect '/'
  end

  post "/login" do
    if User.login params[:username], params[:password]
      @name = User.name_from_username params[:username]
    end
    redirect '/'
  end
end