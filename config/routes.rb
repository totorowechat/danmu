# frozen_string_literal: true

Rails.application.routes.draw do
  get 'about', to: 'static_pages#about'
  get 'document', to: 'static_pages#document'
  get 'examples', to: 'static_pages#examples'

  root 'danmaku#download'
  post '/danmaku/get_video_info', to: 'danmaku#get_video_info'
  get '/danmaku/play_on_mpv/:id', to: 'danmaku#play_on_mpv', as: 'danmaku_play_on_mpv'

  resources :video_items

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
