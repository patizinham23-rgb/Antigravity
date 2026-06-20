class Admin::UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :require_admin

  def index
    @users = User.includes(:enrollments).order(created_at: :desc)
    @pagy, @users = pagy(@users)
  end

  def show
    @user = User.find(params[:id])
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      redirect_to admin_users_path, notice: "Usuário atualizado."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :role, :bio)
  end

  def require_admin
    redirect_to root_path, alert: "Acesso restrito." unless current_user.admin?
  end
end
