class ApplicationController < ActionController::Base
  layout :set_layout
  protect_from_forgery with: :exception

  def set_user
    if user_signed_in?
      User.current = current_user
    end
  rescue ActiveRecord::RecordNotFound
    render_404
  end

  def set_layout
    if is_a?(Devise::SessionsController) || is_a?(Devise::RegistrationsController) || is_a?(Devise::ConfirmationsController) || is_a?(Devise::UnlocksController) || is_a?(Devise::PasswordsController)
      return "authentication"
    end
    "application"
  end
end
