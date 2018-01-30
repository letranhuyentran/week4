Rails.application.routes.draw do

  get "/" => "movies#index"
  get "/movies/new" => 'movies#new'
  get "/movies/create" => 'movies#create'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
