class ApplicationController < ActionController::Base
  rescue_from DeviseLdapAuthenticatable::LdapException do |exception|
    render :text => exception, :status => 500
  end
 
  protect_from_forgery

  before_filter :onering_authenticate!

  def onering_authenticate!
    return nil if Rails.env == 'test'
    if user = authenticate_with_http_basic { |u, p| AdminUser.authenticate_api_user(u,p) }
      @current_admin_user = user
    else
      authenticate_admin_user!
    end
  end

  def current_ability
    @current_ability ||= Ability.new(current_admin_user)
  end

  def current_user
    return nil if Rails.env == 'test'
    @current_admin_user 
  end
end
