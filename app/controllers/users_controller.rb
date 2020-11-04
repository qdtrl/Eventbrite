class UsersController < ApplicationController
  before_action :authenticate_user!
    before_action :only_see_own_page, only: [:show]
    
  def show 
    @user = User.find(params[:id])
    @events = Event.all
  end

  def edit
    
  end

  def update
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to @user, notice: 'User was successfully updated.' }
        format.json { render :show, status: :ok, location: @user }
      else
        format.html { render :edit }
        format.json { render json: @event.errors, status: :unprocessable_entity }
      end
    end
  end

  private

  def only_see_own_page
      @user = User.find(params[:id])
    
      if current_user != @user
        redirect_to root_path, notice: "Sorry, but you are only allowed to view your own profile page."
      end
  end

  def event_params
    params.require(:event).permit(:last_name, :first_name, :description)
  end
end
