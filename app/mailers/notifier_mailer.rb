class NotifierMailer < ApplicationMailer
    default from: 'notifications@torser.in'

    def feedback(user = "", message = "")
        @user_email = user
        @message_body = message
        mail(to: 'rohankapur@mail.com', subject: "#{@user_email} from Torser")
    end
end
