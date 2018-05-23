class UsersController < ApplicationController
  before_action :set_user, only: [:dashboard, :show, :edit, :update, :destroy]

  def map
    @users = User.where.not(latitude: nil, longitude: nil)
    @markers = @Users.map do |user|
      {
        lat: flat.latitude,
        lng: flat.longitude
        # infoWindow: { content: render_to_string(partial: "/users/map_box", locals: { flat: flat }) }
      }
    end
  end

  def edit
  end

  def update
    @user = User.find(params[:id])
    @user.update(user_params)
    @user.save
    redirect_to user_profile_path(current_user)
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


  private

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:first_name, :last_name, :address, :phone_number, :city, :age, :gender, :latitude, :longitude)
  end
end
