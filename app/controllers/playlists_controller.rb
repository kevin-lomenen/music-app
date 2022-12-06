class PlaylistsController < ApplicationController
rescue_from ActiveRecord::RecordNotFound, with: :render_no_record_response
    def index
        playlists=Playlist.all
        render json: playlists, status: :ok
    end
    def show
        playlist=Playlist.find(params[:id])
        render json: playlist, status: :ok
    end

    def create
        
        playlist=Playlist.create!(playlist_params)
        render json: playlist, status: :created
    
    rescue ActiveRecord::RecordInvalid => invalid
    render json: { errors: invalid.record.errors.full_messages }, status: :unprocessable_entity
    end

    def update
        playlist = Playlist.find_by(id: params[:id])
        if playlist

        playlist.update(playlist_params)

        render json: playlist
        
        else
        render json: {error: "Playlist not found"},status: :not_found
        end

        
      end
   
    private
    def render_no_record_response
        render json: {error: "Playlist Not Found"}, status: :not_found
    end
    def playlist_params
        params.permit(:name, :description)
    end
end
