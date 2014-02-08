module PlaceFinder
  class PlaceFinder < Sinatra::Base
    get "/upload" do
      erb :upload
    end

    post "/upload" do
      File.open("uploads/" + params[:file][:filename], "w") do |f|
        f.write(params[:file][:tempfile].read)
      end
    end
  end
end