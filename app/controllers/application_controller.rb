# frozen_string_literal: true

class ApplicationController < ActionController::Base
  before_action :set_theme
  default_form_builder ApplicationFormBuilder

  private

  def set_theme
    return cookies[:theme] if cookies[:theme].present?

    'dark'
  end
end
