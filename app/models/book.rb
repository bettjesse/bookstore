class Book < ApplicationRecord
    has_many :borrowings, dependent: :destroy
    
    validates :title, :author, :isbn, presence: true
    validates :isbn, uniqueness: true
  
    # Returns true if no active (i.e. not returned) borrowing exists for this book.
    def available?
      borrowings.where(returned_at: nil).empty?
    end
  end
  