Rails.application.routes.draw do
  resources :events

  get "todays_stats/", to: "events#get_todays_stats"
  # created new routes under events, created new end point called 
  # todays_stats and mapped to that get_todays_stats method in
  # events controller

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
