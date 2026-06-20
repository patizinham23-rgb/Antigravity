class Users::ProfilesController < ApplicationController
  def show
    @user = current_user
    @enrollments = @user.enrollments.active.includes(course: :instructor)
    @certificates = @user.certificates.recent.includes(:course)
  end

  def edit
    @user = current_user
  end

  def update
    @user = current_user
    if @user.update(profile_params)
      redirect_to profile_path, notice: "Perfil atualizado com sucesso!"
    else
      render :edit, status: :unprocessable_entity
    end
  end

  private

  def profile_params
    params.require(:user).permit(:name, :bio, :avatar)
  end
end
