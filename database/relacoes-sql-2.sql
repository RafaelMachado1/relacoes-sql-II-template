-- Active: 1680730116193@@127.0.0.1@3306
-- Prática 1
CREATE TABLE users(
    id TEXT PRIMARY KEY UNIQUE NOT NULL,
    name TEXT NOT NULL,
    email TEXT UNIQUE NOT NULL,
    password TEXT NOT NULL,
    created_at TEXT DEFAULT (DATETIME('now', 'localtime')) NOT NULL --com aspas simples
);

INSERT INTO users(id, name, email, password)
VALUES
    ('u001', 'Rafael', 'rafael@email.com', 'Rafael123'),
    ('u002', 'Lana', 'lana@email.com', 'Lana123'),
    ('u003', 'Daniel', 'daniel@email.com', 'Daniel123');

SELECT * FROM users;



-- Prática 2 
--Criando a tabela de relações
CREATE TABLE follows(
    follower_id TEXT NOT NULL, --followers que são as pessoas que seguem outras pessoas
    followed_id TEXT NOT NULL, -- followed que são pessoas que estão sendo seguidas
    FOREIGN KEY (follower_id) REFERENCES users(id),
    FOREIGN KEY (followed_id) REFERENCES users(id)
);


INSERT INTO follows(follower_id, followed_id)
VALUES
    ('u001', 'u002'), -- Pessoa A segue B
    ('u001', 'u003'), -- Pessoa A segue C
    ('u002', 'u001'); -- Pessoa B segue A

SELECT * FROM follows;

SELECT * FROM follows -- left
INNER JOIN users
ON follows.follower_id = users.id;


-- Prática 3 
SELECT * FROM follows
RIGHT JOIN users
ON follows.follower_id = users.id;


SELECT
seguidores.id as seguidorId,
seguidores.name as seguidorName,
seguidos.id as seguidosId,
seguidos.name as seguidosName

FROM follows
RIGHT JOIN users as seguidores
ON seguidores.id = follows.follower_id
LEFT JOIN users as seguidos
on seguidos.id = follows.followed_id;






--Fixação 1

CREATE TABLE equipes(
    id TEXT PRIMARY KEY UNIQUE NOT NULL,
    name TEXT NOT NULL
);

CREATE TABLE torcedores(
    id TEXT PRIMARY KEY UNIQUE NOT NULL,
    torcedores_name TEXT NOT NULL
);

CREATE TABLE equipes_torcedores(
    equipes_id TEXT NOT NULL,
    torcedores_equipes_id TEXT NOT NULL,
    FOREIGN KEY (equipes_id) REFERENCES equipes(id),
    FOREIGN KEY (torcedores_equipes_id) REFERENCES torcedores_equipes(id)
);


DROP TABLE equipes;
DROP TABLE torcedores;
DROP TABLE equipes_torcedores;


INSERT INTO equipes(id, name)
VALUES
    ('001', 'Flamengo'),
    ('002', 'vasco');

INSERT INTO torcedores(id, torcedores_name)
VALUES
    ('001', 'Rafael'),
    ('002', 'Lana'),
    ('003', 'Gabriel'),
    ('004', 'Daniel'),
    ('005', 'Davi');


INSERT INTO equipes_torcedores(equipes_id, torcedores_equipes_id)
VALUES
    ('001','a001'),
    ('001','a002'),
    ('002','a003'),
    ('002','a004'),
    ('002','a005');


SELECT * FROM equipes;
SELECT * FROM torcedores;
SELECT * FROM equipes_torcedores;


SELECT 
    equipes.id  AS equipesId,
    equipes.name AS equipesName, 
    torcedores.id AS torcedoresId,
    torcedores.torcedores_name AS torcedoresName
FROM equipes_torcedores
INNER JOIN equipes
ON equipes_torcedores.equipes_id = equipes_id
INNER JOIN torcedores
ON equipes_torcedores.torcedores_equipes_id = torcedores.id;




--Fixação 2

CREATE TABLE books(
    id TEXT PRIMARY KEY UNIQUE NOT NULL,
    name TEXT NOT NULL
);

CREATE TABLE author(
    id TEXT PRIMARY KEY UNIQUE NOT NULL,
    author_name TEXT NOT NULL
);

CREATE TABLE books_author(
    books_id TEXT NOT NULL,
    author_books_id TEXT NOT NULL,
    FOREIGN KEY (books_id) REFERENCES books(id),
    FOREIGN KEY (author_books_id) REFERENCES author_books(id)
);

DROP TABLE books;

DROP TABLE author;

DROP TABLE books_author;

INSERT INTO books(id, name)
VALUES
    ('l001', 'Um dia sem reclamar'),
    ('l002', 'Marketing 5.0: Tecnologia para a humanidade');

INSERT INTO author(id, author_name)
VALUES
    ('a001', 'Davi Lago'),
    ('a002', 'Marcelo Galuppo'),
    ('a003', 'Philip Kotler'),
    ('a004', 'Hermawan Kartajaya'),
    ('a005', 'Iwan Setiawan');

INSERT INTO books_author(books_id, author_books_id)
VALUES
    ('l001','a001'),
    ('l001','a002'),
    ('l002','a003'),
    ('l002','a004'),
    ('l002','a005');

SELECT * FROM books;

SELECT * FROM author;

SELECT * FROM books_author;

SELECT
    books.id AS booksId,
    books.name AS booksName,
    author.id AS authorId,
    author.author_name AS authorName
FROM books_author
INNER JOIN books
ON books_author.books_id = books.id
INNER JOIN author
ON books_author.author_books_id = author.id;