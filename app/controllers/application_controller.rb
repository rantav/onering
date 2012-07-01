class ApplicationController < ActionController::Base
  rescue_from DeviseLdapAuthenticatable::LdapException do |exception|
    render :text => exception, :status => 500
  end
 
  protect_from_forgery

  before_filter :onering_authenticate!

  def onering_authenticate!
    # Require authentication only for HTML pages (API is wide open... for now...)
    respond_to do |format|
      format.html do
        authenticate_admin_user! unless Rails.env == 'test'
      end
      format.json do
        # For API calls we check the database for http basic authentication.
        if user = authenticate_with_http_basic { |u, p| AdminUser.authenticate_api_user(u,p) }
          @current_admin_user = user
        else
          request_http_basic_authentication
        end
      end
    end
  end

  def current_ability
    @current_ability ||= Ability.new(current_admin_user)
  end

  def current_admin_user
    nil if Rails.env == 'test'
    @current_admin_user 
  end
end
