# 📚 Library Management System (PostgreSQL SQL Project)

A complete SQL-based project using **PostgreSQL**, designed to manage library records including books, authors, members, and book loans.

## 🎯 Features
- Add & manage books and authors
- Track borrowing & returns
- Detect overdue books
- Report top borrowed books
- Use stored procedures to issue and return books

## 🛠 Tech Stack
- PostgreSQL
- SQL (DDL + DML + Queries)
- PL/pgSQL stored procedures
- Optional: Python / Node / Java / Django for backend

---

## 📁 Contents
| File | Description |
|------|-------------|
| `schema.sql` | DB structure (tables + keys) |
| `sample_data.sql` | Test dataset |
| `queries.sql` | Beginner to intermediate SQL queries |
| `procedures.sql` | Stored procedures for issuing and returning books |

---

## 🚀 How to Run

### 1️⃣ Create database
```sql
CREATE DATABASE library_db;
```

### 2️⃣ Run schema
```bash
psql -d library_db -f schema.sql
```

### 3️⃣ Load sample data
```bash
psql -d library_db -f sample_data.sql
```

### 4️⃣ Create stored procedures
```bash
psql -d library_db -f procedures.sql
```

### 5️⃣ Run queries
```bash
psql -d library_db -f queries.sql
```

---

## 📊 ER Diagram (Conceptual)

```text
authors 1 --- ∞ books 1 --- ∞ loans ∞ --- 1 members
```

---

## 🔥 What You Will Learn
- PostgreSQL data types  
- Primary & foreign keys  
- JOINs & subqueries  
- Aggregations  
- Constraints  
- DATE functions  
- Stored procedures in PL/pgSQL  
- Good database design practices  

---

## 👨‍💻 Author
Made by <Dharshan J>.  
Feel free to fork, clone, or improve!
