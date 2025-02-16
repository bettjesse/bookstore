require "test_helper"

class BorrowingTest < ActiveSupport::TestCase
  test "due date is set automatically" do
    user = User.create!(email_address: "test@example.com", password: "password", password_confirmation: "password")
    book = Book.create!(title: "Test Book", author: "Test Author", isbn: "98765")
    borrowing = Borrowing.create!(user: user, book: book)
    assert_not_nil borrowing.due_date, "Due date should be set automatically"
    # Allow a delta of 1 day for slight timing differences
    assert_in_delta 2.weeks.from_now.to_date, borrowing.due_date, 1, "Due date should be approximately 2 weeks from now"
  end

  test "cannot borrow a book that's already borrowed" do
    user = User.create!(email_address: "test2@example.com", password: "password", password_confirmation: "password")
    book = Book.create!(title: "Another Book", author: "Another Author", isbn: "11223")
    # Create an initial borrowing record for the book
    Borrowing.create!(user: user, book: book)
    # Try to create a second borrowing for the same book by the same user
    borrowing2 = Borrowing.new(user: user, book: book)
    assert_not borrowing2.valid?, "Should not allow borrowing a book that's already borrowed"
  end
end
