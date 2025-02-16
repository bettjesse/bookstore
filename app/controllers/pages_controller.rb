class PagesController < ApplicationController
  allow_unauthenticated_access only: :home

  def home
    redirect_to user_path(Current.user) if authenticated?
  end

  def dashboard
    # Optionally, you can remove this action if you're not using it.
    unless authenticated?
      redirect_to new_session_path and return
    end

    @active_borrowings = Current.user.borrowings.where(returned_at: nil)
  end
end
