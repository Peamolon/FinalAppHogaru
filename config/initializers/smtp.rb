ActionMailer::Base.smtp_settings = {
  address: 'smtp.sendgrid.net',
  port: 587,
  domain: 'https://caloriesapphogaru.herokuapp.com',
  user_name: ENV['pea.sergi6@gmail.com'],
  password: ENV['Loquendero123'],
  authentication: :login,
  enable_starttls_auto: true
}