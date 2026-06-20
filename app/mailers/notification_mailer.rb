class NotificationMailer < ApplicationMailer
  def welcome(user)
    @user = user
    mail(to: @user.email, subject: "Bem-vindo ao Antigravity LMS!")
  end

  def enrollment_confirmed(user, course)
    @user = user
    @course = course
    mail(to: @user.email, subject: "Matrícula Confirmada - #{course.title}")
  end

  def course_completed(user, course, certificate)
    @user = user
    @course = course
    @certificate = certificate
    mail(to: @user.email, subject: "Parabéns! Curso Concluído - #{course.title}")
  end

  def new_reply(user, thread)
    @user = user
    @thread = thread
    mail(to: @user.email, subject: "Nova resposta no fórum - #{thread.title}")
  end
end
