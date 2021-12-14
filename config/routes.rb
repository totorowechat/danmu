Rails.application.routes.draw do
  get 'about', to: 'static_pages#about'
  get 'document', to: 'static_pages#document'
  get 'examples', to: 'static_pages#examples'
  
  root 'danmaku#download'

  resources :video_items

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
