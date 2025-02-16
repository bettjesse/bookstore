# Book Lending Library Application

This is a simple Book Lending Library application built with **Ruby on Rails 8**. It demonstrates a system where registered users can:

- **Browse Available Books:** View a list of books with details (title, author, and ISBN) and see their availability status.
- **Borrow a Book:** When a user borrows a book, a Borrowing record is created that links the Book to the User with a due date set to 2 weeks from the borrowing date.
- **Return a Book:** Users can return borrowed books, making them available again.
- **View Borrowed Books:** A user profile page displays the books the user currently has borrowed.

## Authentication

This application uses Rails 8's built-in authentication system for login. **Note:** Only login functionality is implemented at the moment (there is no registration form). 

For testing purposes, you can log in with the following credentials:

- **Email:** `example@example.com`
- **Password:** `yourpassword`


# Clone the repo 
```
git clone https://github.com/bettjesse/bookstore.git
cd bookstore
```
# Install Dependencies
```
bundle install
```

#  Run the Application
```
./bin/dev
```
If you need to create a user manually via the Rails console, run:

```bash
bin/rails console
```
Then in the console do 
```
User.create!(email_address: "example@example.com", password: "yourpassword")
```

