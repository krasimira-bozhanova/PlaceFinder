module PlaceFinder
  class PlaceFinder < Sinatra::Base

    post '/comment' do
      @comment = params[:comment_text]
      if Comment.validate_comment(@comment)
        Comment.add_comment :user_id => User.current_user.id,
                            :place_id => params[:place_id].to_i,
                            :comment => @comment
      end
      redirect "/#{params[:place_id]}"
    end

    post '/vote' do
      Rating.add_rating :user_id => User.current_user.id,
                        :place_id => params[:place_id].to_i,
                        :value => params[:vote].to_i
      redirect "/#{params[:place_id]}"
    end
  end
end