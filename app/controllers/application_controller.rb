# frozen_string_literal: true

class ApplicationController < ActionController::Base
  before_action :set_theme, :user_theme

  default_form_builder ApplicationFormBuilder

  private

  def set_theme
    session[:user_theme] = current_theme
  end

  def user_theme
    @user_theme = session[:user_theme]
  end

  def current_theme
    return session[:user_theme] if session[:user_theme].present?

    # TODO: 'Add profile with theme type'
    current_user ? 'dark' : 'dark'
  end
end
