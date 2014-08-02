class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  helper_method :current_client, :status_updates?, :status_updates
  include ApplicationHelper
end
