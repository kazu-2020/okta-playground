# frozen_string_literal: true

Rails.application.routes.draw do
  namespace :scim_v2 do
    get 'Users', to: 'users#index'
    get 'Users/:id', to: 'users#show'
    post 'Users', to: 'users#create'
    put 'Users/:id', to: 'users#replace'
  end
end
