class BorrowingsController < ApplicationController
  def create
    @book = Book.find(params[:id])
    if @book.borrowings.where(returned_at: nil, user_id: Current.user.id).exists?
      flash[:notice] = "You have already borrowed this book."
      redirect_to book_path(@book)
    elsif @book.available?
      Borrowing.create!(user: Current.user, book: @book)
      flash[:notice] = "Book borrowed successfully!"
      redirect_to book_path(@book)
    else
      flash[:alert] = "This book is already borrowed by someone else. Please try again later."
      redirect_to book_path(@book)
    end
  end

  def return
    @borrowing = Borrowing.find(params[:id])
    if @borrowing.user == Current.user && @borrowing.returned_at.nil?
      @borrowing.update(returned_at: Time.current)
      flash[:notice] = "Book returned successfully!"
      redirect_to user_path(Current.user)
    else
      flash[:alert] = "Unable to return book."
      redirect_to user_path(Current.user)
    end
  end
end
