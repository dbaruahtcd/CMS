class AccessController < ApplicationController
  layout 'admin'

  before_action :confirm_logged_in, except: [:login, :attempt_login, :logout]

  def menu
    # display text and links
    @username = session[:username]
  end

  def login
    #login form
  end

  def attempt_login
    if params[:username].present? && params[:password].present?
      #hash sanitize values for us && where won't return an error if no record found
      found_user = AdminUser.where(username: params[:username]).first
      if found_user
        authorized_user = found_user.authenticate(params[:password])
      end
    end

    if authorized_user
      session[:user_id] = authorized_user.id
      session[:username] = authorized_user.username
      flash[:notice] = 'You are not logged in.'
      redirect_to(admin_path)
    else
      #except for the next request we are telling it that the notice has to be shown now.
      flash.now[:notice] = 'Invalid username password combination.'
      render('login')
    end
  end

  def logout
    session[:user_id] = nil
    session[:username] = nil
    flash[:notice] = 'Logged out'
    redirect_to(access_login_path)
  end
end
