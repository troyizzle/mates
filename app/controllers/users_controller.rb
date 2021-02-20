class UsersController < ApplicationController
  def toggle_theme
    theme = cookies[:theme] == 'dark' ? 'light' : 'dark'

    cookies[:theme] = theme

    current_user&.update_theme(theme)

    render json: {
      theme: theme,
      template: ApplicationController.render(partial: '/layouts/menu_links',
                                             locals: { current_user: current_user,
                                                       theme: theme })
    }
  end
end
