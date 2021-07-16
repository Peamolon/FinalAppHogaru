class ShareMailer < ApplicationMailer
    def send_link(email)
        mail(to: email, subject: "Bienvenido", from: "pea.sergi6@gmail.com")
    end
end
