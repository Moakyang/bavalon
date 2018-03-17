require 'byebug'

class V1::PlayersController < ApplicationController
  def index
    @players = Player.find_by_room_id(params[:room_id])
    render 'v1/players/show'
  end

  def create
    @players = Player.new()
    @players.room = Room.find(params[:room_id])
    @players.owner_id = @players.room.owner_id
    @players.players = ''
    if @players.save
      render 'v1/players/show'
    else
      render json: @players.errors.full_messages, status: 422
    end
  end

  def update
    @players = Player.find(params[:id])
    updated_players = @players.players.split(',').push(params[:playername]).uniq.join(',')
    @players.players = updated_players
    @players.save


    RoomChannel.broadcast_to(
      current_user,
      players: @players.players
    )

    render 'v1/players/show'
  end

  private

  def player_params
    params.require(:players).permit(:room_id, :players, :owner_id, :playerName)
  end
end
