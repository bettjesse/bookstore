class PagesController < ApplicationController
  allow_unauthenticated_access only: :home

  def home
    redirect_to dashboard_path if authenticated?
  end

  def dashboard
    unless authenticated?
      redirect_to new_session_path and return
    end

    # Load active borrowings for the current user (i.e. not yet returned)
    @active_borrowings = Current.user.borrowings.where(returned_at: nil)
  end
end
