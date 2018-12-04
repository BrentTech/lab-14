#books database normalization -> books & bookshelf

<!-- create new table -->
CREATE TABLE bookshelves (id SERIAL KEY, name VARCHAR(255));

<!-- populate bookshelves table with repetitive data from books -->
INSERT INTO bookshelves(name) SELECT DISTINCT bookshelf FROM books;

<!-- create column in books table that will become the foreign key -->
ALTER TABLE books ADD COLUMN bookshelf_id INT;

<!-- update books table foreign key column to reflect primary key of bookshelf -->
UPDATE books SET bookshelf_id=shelf.id FROM (SELECT * FROM bookshelves) AS shelf WHERE books.bookshelf=shelf.name;

<!-- remove redundant bookshelf name -->
ALTER TABLE books DROP COLUMN bookshelf;

<!-- create connects/constraint between primary key of bookshelves and book fk column -->
ALTER TABLE books ADD CONSTRAINT fk_bookshelves FOREIGN KEY (bookshelf_id) REFERENCES bookshelves(id);
