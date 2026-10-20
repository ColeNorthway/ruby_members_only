class ApplicationController < ActionController::Base
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern

  # Changes to the importmap will invalidate the etag for HTML responses
  stale_when_importmap_changes

  before_action :authenticate

  private

  def authenticate
    unless logged_in?
      flash[:error] = "Error you need to be signed in to view that"
      redirect_to posts_path
    end
  end

  def logged_in?
    return false if cookies.encrypted[:clubhouse_ticket].nil?

    user = User.find_by(id: cookies.encrypted[:clubhouse_ticket])
    return false if user.nil?

    return false if user.remember != cookies.encrypted[:clubhouse_ticket]
    true
  end
end
