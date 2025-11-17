-- Stored procedure to issue a book to a member
-- Uses basic validation on availability and existence
CREATE OR REPLACE PROCEDURE issue_book(
    p_book_id INT,
    p_member_id INT,
    p_issue_date DATE DEFAULT NULL,
    p_due_date DATE DEFAULT NULL
)
LANGUAGE plpgsql
AS $$
DECLARE
    v_available INT;
BEGIN
    -- Lock and check the book row
    SELECT available_copies
    INTO v_available
    FROM books
    WHERE book_id = p_book_id
    FOR UPDATE;

    IF NOT FOUND THEN
        RAISE EXCEPTION 'Book with id % not found', p_book_id;
    END IF;

    IF v_available <= 0 THEN
        RAISE EXCEPTION 'No available copies for book id %', p_book_id;
    END IF;

    -- Check member exists
    PERFORM 1 FROM members WHERE member_id = p_member_id;
    IF NOT FOUND THEN
        RAISE EXCEPTION 'Member with id % not found', p_member_id;
    END IF;

    -- Insert loan
    INSERT INTO loans (book_id, member_id, issue_date, due_date, return_date)
    VALUES (
        p_book_id,
        p_member_id,
        COALESCE(p_issue_date, CURRENT_DATE),
        COALESCE(p_due_date, CURRENT_DATE + INTERVAL '7 days'),
        NULL
    );

    -- Update available copies
    UPDATE books
    SET available_copies = available_copies - 1
    WHERE book_id = p_book_id;
END;
$$;

-- Stored procedure to return a book
CREATE OR REPLACE PROCEDURE return_book(
    p_loan_id INT,
    p_return_date DATE DEFAULT NULL
)
LANGUAGE plpgsql
AS $$
DECLARE
    v_book_id INT;
    v_returned DATE;
BEGIN
    -- Lock the loan row
    SELECT book_id, return_date
    INTO v_book_id, v_returned
    FROM loans
    WHERE loan_id = p_loan_id
    FOR UPDATE;

    IF NOT FOUND THEN
        RAISE EXCEPTION 'Loan with id % not found', p_loan_id;
    END IF;

    IF v_returned IS NOT NULL THEN
        RAISE EXCEPTION 'Loan % is already returned', p_loan_id;
    END IF;

    -- Update loan with return date
    UPDATE loans
    SET return_date = COALESCE(p_return_date, CURRENT_DATE)
    WHERE loan_id = p_loan_id;

    -- Increase available copies
    UPDATE books
    SET available_copies = available_copies + 1
    WHERE book_id = v_book_id;
END;
$$;

-- Stored procedure to register a new member
CREATE OR REPLACE PROCEDURE register_member(
    p_name VARCHAR,
    p_email VARCHAR
)
LANGUAGE plpgsql
AS $$
BEGIN
    INSERT INTO members (name, email)
    VALUES (p_name, p_email);
END;
$$;

-- Example calls (commented out)
-- CALL issue_book(1, 1, '2025-11-15', '2025-11-22');
-- CALL return_book(1, '2025-11-20');
-- CALL register_member('David', 'david@example.com');
