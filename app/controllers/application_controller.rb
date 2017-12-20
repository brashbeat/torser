class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  def index
  end

  def me
  end
    
  def feedform
      @user_mail = params[:email]
      @body = params[:message]
      NotifierMailer.feedback(@user_mail, @body).deliver_later
      flash[:thanks] = "Thank you, your message has been successfully sent!"
      redirect_to '/me'  
  end

end
