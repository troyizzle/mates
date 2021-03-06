Rails.application.routes.draw do
  root 'home#index'
  devise_for :users,
             controllers: { registrations: 'users/registrations',
                            omniauth_callbacks: 'users/omniauth_callbacks',
                            sessions: 'users/sessions' }
  post '/users/toggle-theme',
       to: 'users#toggle_theme',
       constraints: { format: :js }
end
