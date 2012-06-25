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
      format.json {}
    end
  end
end
