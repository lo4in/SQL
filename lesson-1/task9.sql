-- Создание таблицы книг
CREATE TABLE Book (
    book_id SERIAL PRIMARY KEY,
    title TEXT NOT NULL,
    author TEXT NOT NULL,
    published_year INTEGER
);

-- Создание таблицы членов библиотеки
CREATE TABLE Member (
    member_id SERIAL PRIMARY KEY,
    name TEXT NOT NULL,
    email TEXT UNIQUE NOT NULL,
    phone_number TEXT NOT NULL
);

-- Создание таблицы выдачи книг
CREATE TABLE Loan (
    loan_id SERIAL PRIMARY KEY,
    book_id INTEGER REFERENCES Book(book_id) ON DELETE CASCADE,
    member_id INTEGER REFERENCES Member(member_id) ON DELETE CASCADE,
    loan_date DATE NOT NULL,
    return_date DATE
);

-- Вставка данных в таблицу Book
INSERT INTO Book (title, author, published_year) VALUES
    ('1984', 'George Orwell', 1949),
    ('To Kill a Mockingbird', 'Harper Lee', 1960),
    ('The Great Gatsby', 'F. Scott Fitzgerald', 1925);

-- Вставка данных в таблицу Member
INSERT INTO Member (name, email, phone_number) VALUES
    ('Alice Johnson', 'alice@example.com', '123-456-7890'),
    ('Bob Smith', 'bob@example.com', '987-654-3210');

-- Вставка данных в таблицу Loan
INSERT INTO Loan (book_id, member_id, loan_date, return_date) VALUES
    (1, 1, '2024-02-01', NULL),
    (2, 2, '2024-02-03', '2024-02-15');
