Rails.application.routes.draw do
  root 'site#index'

  get "/about" => 'site#about'
  get "/resume" => 'site#resume'
end
