require "test_helper"

class BorrowingsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = User.create!(email_address: "test@example.com", password: "password", password_confirmation: "password")
    @book = Book.create!(title: "Test Book", author: "Test Author", isbn: "unique-001")
   
    post session_path, params: { session: { email_address: @user.email_address, password: "password" } }
    # If that still doesn't work or causes errors, try setting the cookie directly:
    cookies[:user_id] = @user.id
  end

  teardown do
    # Clear the cookie
    cookies.delete(:user_id)
    # Optionally clear Current.session if needed:
    Current.session = nil
  end

  test "should borrow a book if available" do
    assert @book.available?, "Book should be available initially"
    
    post borrow_book_path(@book)
    assert_redirected_to book_path(@book)
    follow_redirect!
    
    borrowing = Borrowing.find_by(book: @book, user: @user, returned_at: nil)
    assert_not_nil borrowing, "Borrowing record should be created"
  end

  test "should not allow borrowing a book already borrowed by the same user" do
    post borrow_book_path(@book)
    assert_redirected_to book_path(@book)
    follow_redirect!
    
    post borrow_book_path(@book)
    assert_redirected_to book_path(@book)
    follow_redirect!
    
    assert_match /already borrowed/, response.body
  end

  test "should return a borrowed book" do
    post borrow_book_path(@book)
    borrowing = Borrowing.find_by(book: @book, user: @user, returned_at: nil)
    assert_not_nil borrowing, "Borrowing record should exist"
    
    patch return_borrowing_path(borrowing)
    assert_redirected_to books_path
    follow_redirect!
    
    borrowing.reload
    assert_not_nil borrowing.returned_at, "Borrowing record should be marked as returned"
  end
end
