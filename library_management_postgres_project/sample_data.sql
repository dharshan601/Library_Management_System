INSERT INTO authors (name, country) VALUES
('J.K. Rowling', 'UK'),
('George Orwell', 'UK'),
('Mark Twain', 'USA'),
('Haruki Murakami', 'Japan');

INSERT INTO books (title, author_id, category, published_year, total_copies, available_copies) VALUES
('Harry Potter', 1, 'Fantasy', 1997, 5, 5),
('1984', 2, 'Dystopian', 1949, 3, 3),
('Animal Farm', 2, 'Political Satire', 1945, 4, 4),
('Norwegian Wood', 4, 'Fiction', 1987, 2, 2);

INSERT INTO members (name, email) VALUES
('Alice', 'alice@example.com'),
('Bob', 'bob@example.com'),
('Charlie', 'charlie@example.com');

INSERT INTO loans (book_id, member_id, issue_date, due_date, return_date) VALUES
(1, 1, '2025-11-01', '2025-11-10', NULL),
(2, 2, '2025-11-02', '2025-11-12', '2025-11-08'),
(3, 3, '2025-11-03', '2025-11-13', NULL);
