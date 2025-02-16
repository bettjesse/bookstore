class UsersController < ApplicationController
  def show
    @user = Current.user
    @active_borrowings = @user.borrowings.where(returned_at: nil)
  end
end
