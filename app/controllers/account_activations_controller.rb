class AccountActivationsController < ApplicationController
  before_action :set_user, only: :edit

  def edit
    return redirect_to root_url, danger: "Invalid activation link" unless valid_activated?
    @user.activate
    log_in @user
    redirect_to @user, flash: {success: 'Account activated!'}
  end

  private

    def set_user
      @user = User.find_by(email: params[:email])
    end
  
    def valid_activated?
      @user && !@user.activated? && @user.authenticated?(:activation, params[:id])
    end
end