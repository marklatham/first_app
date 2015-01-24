class AdminMailer < ActionMailer::Base

  def new_registration(user)
    @user = user
    mail from: Rails.application.secrets.admin_email,
           to: Rails.application.secrets.admin_email,
      subject: "New registration"
  end
  
  def votes_tally(cutoff_time)
    @cutoff_time = cutoff_time
    mail from: Rails.application.secrets.admin_email,
           to: Rails.application.secrets.admin_email,
      subject: "Votes tally run"
  end
end
