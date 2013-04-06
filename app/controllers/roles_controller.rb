class RolesController < ApplicationController
  load_resource :user

  def update
    authorize! :update, :role

    @user.role = params[:user][:role]

    if @user.save
      flash[:notice] = 'User role was successfully updated.'
      redirect_to user_path(@user)
    else
      flash[:error] = "User role wasn't updated."
      redirect_to edit_user_path(@user)
    end
  end
end
