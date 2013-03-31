class UsersController < ApplicationController
  load_and_authorize_resource :user

  def show
  end

  def edit
  end

  def update
    if @user.update_attributes(params[:user])
      flash[:notice] = 'User was successfully updated.'
      render :show
    else
      render :edit
    end
  end
end
