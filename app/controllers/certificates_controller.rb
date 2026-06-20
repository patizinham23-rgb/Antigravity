class CertificatesController < ApplicationController
  before_action :authenticate_user!

  def index
    @certificates = current_user.certificates.recent.includes(:course)
  end

  def show
    @certificate = current_user.certificates.find(params[:id])
    @course = @certificate.course
    @user = @certificate.user

    respond_to do |format|
      format.html
      format.pdf
    end
  end
end
