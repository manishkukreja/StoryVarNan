ActionMailer::Base.smtp_settings = {
  :address              => "smtp.gmail.com",
  :port                 => 587,
  :domain               => "gmail.com",
  :user_name            => "manishkukreja",
  :password             => "imnewton",
  :authentication       => "plain",
  :enable_starttls_auto => true
}