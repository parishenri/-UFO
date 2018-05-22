class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]

  def new
  end

  def create
  end

  def edit
  end

  def udpate
    #already finds
  end

  def show
    #already finds
  end

  def destroy
    #already finds
    @user.destroy
    respond_to do |format|
      format.html { redirect_to users_url, notice: 'User was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  def set_user
    @user = User.find(params[:id])
  end
end
