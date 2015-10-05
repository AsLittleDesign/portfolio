Rails.application.routes.draw do
  get "application/base"

  root :to => 'base#index'
  get "/about" => 'base#about'
end
