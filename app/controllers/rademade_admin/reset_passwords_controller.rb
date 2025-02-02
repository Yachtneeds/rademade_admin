# -*- encoding : utf-8 -*-
module RademadeAdmin
  class ResetPasswordsController < RademadeAdmin::ApplicationController

    layout 'login'

    skip_before_action :require_login

    def show
      # params[:id] is JWT token
      @user = UserPasswordToken.decode(params[:id])
    rescue
      redirect_to root_path
    end

    def update
      user = UserPasswordToken.decode(params[:id])
      data = params.require(:data).permit(:password, :password_repeat).merge(user: user).to_hash.symbolize_keys

      RademadeAdmin::ResetPassword.call(data)

      render json: { redirect_to: login_url }
    rescue RademadeAdmin::FieldError => e
      render json: { errors: e.error_hash }, status: :precondition_failed
    rescue JWT::DecodeError
      render json: { message: 'Error', with_return: true }, status: 404
    end
  end
end
