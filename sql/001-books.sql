BEGIN;

CREATE TABLE books (
    isbn   ISBN13   PRIMARY KEY,
    title  TEXT     NOT NULL DEFAULT '',
    rating SMALLINT NOT NULL DEFAULT 0 CHECK (rating BETWEEN 0 AND 5)
);

CREATE TABLE authors (
    id         BIGSERIAL PRIMARY KEY,
    surname    TEXT NOT NULL DEFAULT '',
    given_name TEXT NOT NULL DEFAULT ''
);

CREATE TABLE book_author (
    isbn       ISBN13 REFERENCES books(isbn),
    author_id  BIGINT REFERENCES authors(id),
    PRIMARY KEY (isbn, author_id)
);

INSERT INTO books
VALUES ('1587201534',        'CCSP SNRS Exam Certification Guide', 5),
       ('978-0201633467',    'TCP/IP Illustrated, Volume 1',       5),
       ('978-0130183804',    'Internetworking with TCP/IP Vol.1',  4),
       ('978-1-56592-243-3', 'Perl Cookbook',                      5),
       ('978-0735712010',    'Designing with Web Standards',       5)
;

INSERT INTO authors (surname, given_name)
VALUES ('Bastien',      'Greg'),
       ('Nasseh',       'Sara'),
       ('Degu',         'Christian'),
       ('Stevens',      'Richard'),
       ('Comer',        'Douglas'),
       ('Christiansen', 'Tom'),
       ('Torkington',   'Nathan'),
       ('Zeldman',      'Jeffrey')
;

INSERT INTO book_author
VALUES ('1587201534',        1),
       ('1587201534',        2),
       ('1587201534',        3),
       ('978-0201633467',    4),
       ('978-0130183804',    5),
       ('978-1-56592-243-3', 6),
       ('978-1-56592-243-3', 7),
       ('978-0735712010',    8);

COMMIT;
