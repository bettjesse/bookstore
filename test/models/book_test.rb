require "test_helper"

class BookTest < ActiveSupport::TestCase
  test "should not save book without title" do
    book = Book.new(author: "Some Author", isbn: "12345")
    assert_not book.save, "Saved the book without a title"
  end

  test "should not save book without author" do
    book = Book.new(title: "Some Title", isbn: "12345")
    assert_not book.save, "Saved the book without an author"
  end

  test "should not save book without isbn" do
    book = Book.new(title: "Some Title", author: "Some Author")
    assert_not book.save, "Saved the book without an ISBN"
  end

  test "should not allow duplicate ISBN" do
    book1 = Book.create!(title: "Book One", author: "Author One", isbn: "12345")
    book2 = Book.new(title: "Book Two", author: "Author Two", isbn: "12345")
    assert_not book2.save, "Allowed duplicate ISBN"
  end

  test "available? returns true when no active borrowings" do
    book = Book.create!(title: "Unique Book", author: "Unique Author", isbn: "54321")
    assert book.available?, "Book should be available if no borrowings exist"
  end
end
