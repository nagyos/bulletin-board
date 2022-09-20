Rails.application.routes.draw do

  get "user/sign_in" => "user#sign_in"
  get "user/sign_up" =>"user#sign_up"

  get "posts/new" => "posts#new"
  get "posts/:id" => "posts#show"
  post "posts/create" => "posts#create"
  get "posts/:id/edit" => "posts#edit"
  post "posts/:id/update" => "posts#update"
  post "posts/:id/destroy" => "posts#destroy"



  get '/' => "home#top"

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
