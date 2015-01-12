class AdminMailer < ActionMailer::Base

  def new_registration(user)
    @user = user
    mail from: "vaninfocoop@gmail.com", to: "vaninfocoop@gmail.com", subject: "New registration"
  end
end
