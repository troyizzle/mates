# frozen_string_literal: true

class ApplicationController < ActionController::Base
  before_action :set_theme, :user_theme

  default_form_builder ApplicationFormBuilder

  private

  def set_theme
    cookies[:user_theme] = current_theme
  end

  def user_theme
    @user_theme = cookies[:user_theme]
  end

  def current_theme
    return cookies[:user_theme] if cookies[:user_theme].present?

    # TODO: 'Add profile with theme type'
    current_user ? 'dark' : 'dark'
  end
end
