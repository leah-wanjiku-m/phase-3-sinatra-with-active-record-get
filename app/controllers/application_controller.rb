class ApplicationController < Sinatra::Base
  set :default_content_type, 'application/json'

  get '/' do
    { message: "Hello world" }.to_json(:title).limit(10)
  end
  get '/games' do
    # get all the games from the database
    games = Game.all.order
    # return a JSON response with an array of all the game data
    games.to_json
  end
  get '/games/:id' do
    game = Game.find(params[:id])
    game.to_json(only: [:id, :title, :genre, :price], include: {
      reviews: { only: [:comment, :score], include: {
        user: { only: [:name] }
      } }
    })
  end


end
