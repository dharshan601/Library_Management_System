-- 1. List all books
SELECT * FROM books;

-- 2. List all members
SELECT * FROM members;

-- 3. Join books with authors
SELECT b.title, a.name AS author
FROM books b
JOIN authors a ON b.author_id = a.author_id;

-- 4. Currently borrowed books
SELECT m.name, b.title, l.issue_date, l.due_date
FROM loans l
JOIN members m ON l.member_id = m.member_id
JOIN books b ON l.book_id = b.book_id
WHERE l.return_date IS NULL;

-- 5. Overdue books
SELECT m.name, b.title, l.due_date
FROM loans l
JOIN members m ON l.member_id = m.member_id
JOIN books b ON l.book_id = b.book_id
WHERE l.return_date IS NULL
  AND l.due_date < CURRENT_DATE;

-- 6. Count books per category
SELECT category, COUNT(*) AS total_books
FROM books
GROUP BY category;

-- 7. Most borrowed books
SELECT b.title, COUNT(*) AS times_borrowed
FROM loans l
JOIN books b ON l.book_id = b.book_id
GROUP BY b.title
ORDER BY times_borrowed DESC;

-- 8. Available vs borrowed copies
SELECT title, total_copies, available_copies,
       (total_copies - available_copies) AS borrowed
FROM books;

-- 9. Members who borrowed more than 1 book
SELECT m.name, COUNT(*) AS total_loans
FROM loans l
JOIN members m ON l.member_id = m.member_id
GROUP BY m.name
HAVING COUNT(*) > 1;

-- 10. Author with highest number of books
SELECT a.name, COUNT(b.book_id) AS total_books
FROM authors a
JOIN books b ON a.author_id = b.author_id
GROUP BY a.name
ORDER BY total_books DESC;

-- 11. Loans per member with last issue date
SELECT m.name,
       COUNT(l.loan_id) AS total_loans,
       MAX(l.issue_date) AS last_issued
FROM members m
LEFT JOIN loans l ON m.member_id = l.member_id
GROUP BY m.name
ORDER BY total_loans DESC;

-- 12. Books not yet borrowed
SELECT b.*
FROM books b
LEFT JOIN loans l ON b.book_id = l.book_id
WHERE l.loan_id IS NULL;
