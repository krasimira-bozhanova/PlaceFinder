module PlaceFinder
  class PlaceFinder < Sinatra::Base
    get '/search' do
      @type_options = Type.all.sort_by(&:name)
      @residential_complex_options = ResidentialComplex.all.sort_by(&:name)
      erb :search
    end

    post "/search" do
      type, zhk = [params[:type], params[:zhk]].map(&:to_i)
      if type == 0  and zhk == 0
        @result_places = Place.all
      else
        @result_places = Place.filter(type, zhk)
      end
      erb :filtered
    end
  end
end