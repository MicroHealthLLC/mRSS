class ProfilesController < ApplicationController

  def edit
  end

  def update
    if current_user.valid_password?(params[:user][:current_password])
      if current_user.update(profile_params)
        flash[:notice] = "Profile was updated successfully."
        redirect_to root_path
      else
        flash[:notice] = "Incorrect Password,try again.."
        render 'edit'
      end
    end
  end

  private
  def profile_params
    params.require(:user).permit(
      :login,
      :email,
      :password
    )
  end
end
