
module SessionsHelper

  def sign_in(user)
    cookies.permanent.signed[:remember_token] = [user.id, user.salt]
    self.current_user = user
  end

  def current_user=(user)
    @current_user = user
  end
  def deny_access
    redirect_to new_session_path, :notice => "Please sign in to access this page."
  end

  def current_user?(user)
    user == current_user
  end

  def signed_in?
    !current_user.nil?
  end

  def user_from_remember_token
    User.authenticate_with_salt(*remember_token)
  end

  def current_user
    @current_user ||= user_from_remember_token
  end

  def sign_out
    cookies.delete(:remember_token)
    self.current_user = nil
  end



  private


  def remember_token
    cookies.signed[:remember_token] || [nil, nil]
  end
end