BEGIN;

CREATE VIEW books_with_authors AS
SELECT b.isbn, b.title, b.rating,
       array_to_string(array_agg(a.surname), ', ') as authors
  FROM books       b
  JOIN book_author ba ON b.isbn     = ba.isbn
  JOIN authors     a  ON ba.author_id = a.id
 GROUP BY b.isbn, b.title, b.rating;

COMMIT;
