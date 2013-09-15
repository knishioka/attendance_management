AttendanceManagement::Application.routes.draw do
  root to: "home#index"
  get '/auth/:provider/callback', to: 'sessions#create'
  get :logout, to: "sessions#logout", as: :logout

  resources :attendances
end
