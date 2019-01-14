Rails.application.routes.draw do
  resources :achievements
  root to: 'welcome#index'
end
