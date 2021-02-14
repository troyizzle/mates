Rails.application.routes.draw do
  root 'home#index'
  devise_for :users,
             controllers: { registrations: 'users/registrations',
                            sessions: 'user/sessions' }
end
